require 'sinatra/base'

require 'initializers/config'

require 'lib/echonest'
require 'lib/spotify'

module Muzak
  class App < Sinatra::Base
    get '/' do    
      erb :index
    end 

    get '/weather/:lat/:long' do
    	url = "http://api.wunderground.com/api/#{Muzak.config.wunderground_api_key}/geolookup/conditions/astronomy/q/#{params[:lat]},#{params[:long]}.json"
    	HTTParty.get(url).body
    end

    get '/spotify/:name' do
    	Spotify.track_id_from_term(params[:name])
    end 
  end  
end