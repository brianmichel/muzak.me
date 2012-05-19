require 'httparty'
require 'json'
require 'uri'

module EchoNest
  def self.new(*args)
    Client.new(*args)
  end  
  
  class Song
    def initialize(args = {})
      @id = args['id']
      @artist_id = args['artist_id']
      @artist_name = args['artist_name']
      @title = args['title']
      @artist_hotttnesss = args['artist_hotness']
      @song_hotttnesss = args['song_hotttnesss']
      @artist_familiarity = args['artist_familiarity']
      
      if foreign_ids = args['foreign_ids']
        foreign_ids.each do |fi|
          if fi['catalog'] == 'spotify-WW'
            @spotify_id = fi['id'] 
            break
          end  
        end  
      end  
    end  
    
    attr_reader :id, :artist_id, :id, :artist_name, :title, 
      :artist_hotttness, :song_hotttnesss, :artist_familiarity, :spotify_id
      
  end
  
  class Term
    def initialize(args = {})
      args.each do |k,v|
        self.instance_variable_set("@#{k}", v)
      end  
    end 
    
    attr_reader :name
    
    alias_method :to_s, :name
  end    
  
  class Client
    class ApiRequestError < StandardError; end;
        
    BASE_URL = 'http://developer.echonest.com/api/v4/'
  
    def initialize(api_key)
      @api_key = api_key
    end  
    
    def styles
      terms :style
    end
    
    def moods
      terms :mood
    end    
    
    def songs_for_mood(mood)
      resp  = get 'song/search', {mood: mood}
      songs = resp['response']['songs']
    
      songs.collect { |s| Song.new s }
    rescue ApiRequestError
      []  
    end
    
    def songs(query = {}) 
      resp  = get 'song/search', query
      songs = resp['response']['songs']
      
      songs.collect { |s| Song.new s }
    end     
  
    private 
    
    def terms(type)
      type = type.to_sym
    
      resp  = get 'artist/list_terms', {type: type}
      terms = resp['response']['terms']
          
      terms.collect { |t| Term.new t }
    rescue ApiRequestError
      []  
    end
  
    def get(node, params = {})
      params.merge!({api_key: @api_key, format: 'json'})
          
      url  = BASE_URL + node   
      url  = url + '?' + params.collect { |k,v| "#{k}=#{v}" }.join('&') 
      resp = HTTParty.get( URI.encode(url) )
          
      if resp.response.code == '200'
        JSON.parse resp.body
      else
        raise ApiRequestError, "#{url} responded with #{resp.response.code}"
      end    
    end 
  end   
end  