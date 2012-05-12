require 'sinatra/base'

module Muzak
  class App < Sinatra::Base
    get '/' do
      "gfy"
    end  
  end  
end  