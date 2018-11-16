# this will take the place of app.rb from now on
# it's the primary class in our app
# note that it inherits from Sinatra Base application
class ApplicationController < Sinatra::Base

  require 'bundler'
  Bundler.require()

  # enable sessions
  enable :sessions # yep that's it

  # set up db connection
  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'salty_items'
  )

  # enable cors
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
  end

  set :allow_origin, :any
  set :allow_credentials, true
  set :allow_methods, [:get, :post, :put, :patch, :delete, :options]



  # use some middleware to allow us to process delete/put/patch etc requests
  use Rack::MethodOverride # like express, we "use" middleware in Rack-based libraries/frameworks
  set :method_override, true


  # teach it where views live
  set :views, File.expand_path('../../views', __FILE__)

  # teach it where static assets live
  set :public_dir, File.expand_path('../../public', __FILE__)


  # telling the browser what's ok and what's not
  options '*' do 
    puts "options request received"
    response.headers['Allow'] = 'HEAD, GET, POST, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Authorization, Content-Type, Cache-Control, Accept"
    200 #this is the status code & also sends a response
  end


  get '/' do
    # @hey = "hey shilpa with the shoes"

    # # binding.pry will pause exectuion and 
    # # open a REPL where you can mess around in that scope in the code
    # # you can inspect variables
    # # test out DB queries
    # # you can enter ruby statements directly
    # # whatever
    # # just be sure to type exit when you're done
    # # because the client is still waiting for that response
    binding.pry

    # @hey
    redirect '/items'
  end

  get '/template' do
    erb :hello

  end


  get '*' do
    response = ""
    404.times { response += "404 "}
    response
  end


end