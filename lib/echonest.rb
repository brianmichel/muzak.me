hrequire 'httparty'
require 'json'

module Muzak
  module EchoNest
    def self.new(*args)
      Client.new(*args)
    end  
    
    class Song
      attr_reader :artist_id, :id, :artist_name, :title
      
      def initialize(args = {})
        args.each do |k,v|
          self.instance_variable_set("@#{k}", v)
        end
      end  
    end
    
    class Term
      attr_reader :name
          
      def initialize(args = {})
        args.each do |k,v|
          self.instance_variable_set("@#{k}", v)
        end  
      end  
    end    
    
    class Client
      class ApiRequestError < StandardError; end;
          
      BASE_URL = 'http://developer.echonest.com/api/v4/'
    
      def initialize(api_key)
        @api_key = api_key
      end  
    
      def terms(type = :style)
        type = type.to_sym
      
        resp  = get 'artist/list_terms', {type: type}
        terms = resp['response']['terms']
            
        terms.collect { |t| Term.new t }
      rescue ApiRequestError
        []  
      end
    
      def songs_for_mood(mood)
        resp  = get 'song/search', {mood: mood}
        songs = resp['response']['songs']
      
        songs.collect { |s| Song.new s }
      rescue ApiRequestError
        []  
      end    
    
      private 
    
      def get(node, params = {})
        params.merge!({api_key: @api_key, format: 'json'})
            
        url  = BASE_URL + node   
        url  = url + '?' + params.collect { |k,v| "#{k}=#{v}" }.join('&') 
        resp = HTTParty.get(url)
            
        if resp.response.code == '200'
          JSON.parse resp.body
        else
          raise ApiRequestError
        end    
      end 
    end   
  end  
end