require 'httparty'
require 'json'

module Muzak
  class EchoNest
    class ApiRequestError < StandardError; end;
    
    BASE_URL = 'http://developer.echonest.com/api/v4/'
    
    def initialize(api_key)
      @api_key = api_key
    end  
    
    def terms(type = :style)
      type = type.to_sym
      
      resp  = get 'artist/list_terms', {type: type}
      terms = resp['response']['terms']
            
      terms.collect { |t| t['name'] }
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