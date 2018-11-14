# this will take the place of app.rb from now on
# it's the primary class in our app
# note that it inherits from Sinatra Base application
class ApplicationController < Sinatra::Base

  require 'bundler'
  Bundler.require()

  set :views, File.expand_path('../../views', __FILE__)




  get '/' do
    @hey = "hey shilpa with the shoes"

    # binding.pry will pause exectuion and 
    # open a REPL where you can mess around in that scope in the code
    # you can inspect variables
    # test out DB queries
    # you can enter ruby statements directly
    # whatever
    # just be sure to type exit when you're done
    # because the client is still waiting for that response
    binding.pry

    @hey
  end

  get '/template' do
    erb :hello

  end


end