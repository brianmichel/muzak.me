require 'sinatra/base'

require 'initializers/config'

require 'lib/echonest'
require 'lib/spotify'

module Muzak
  class App < Sinatra::Base
    get '/' do    
      erb :index
    end  
  end  
end  