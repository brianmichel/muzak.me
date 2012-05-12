require 'sinatra/base'

module Muzak
  class App < Sinatra::Base
    get '/' do
      erb :index
    end  
  end  
end  