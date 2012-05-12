require 'sinatra/base'

require 'initializers/config'

require 'lib/echonest'
require 'lib/spotify'

module Muzak
  class App < Sinatra::Base
    get '/' do    
      erb :index
    end 

    get '/spotify/:name' do
    	Spotify.track_id_from_term(params[:name])
    end 
  end  
end  