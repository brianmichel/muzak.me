require 'sinatra/base'
require 'sinatra/activerecord'

require 'initializers/config'

require 'lib/echonest'
require 'lib/spotify'

require 'lib/models/song'

module Muzak
  class App < Sinatra::Base
    configure :development do
      #config = YAML::load(File.open("config/database.yml"))
      ActiveRecord::Base.establish_connection(
        :adapter  => 'sqlite3',
        :database => 'db/development.db'
      )    
    end
    
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