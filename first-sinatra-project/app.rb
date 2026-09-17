require "sinatra"

class FirstApp < Sinatra::Base

    get "/" do
      @someone = "John"
      erb :hello
    
    end
end