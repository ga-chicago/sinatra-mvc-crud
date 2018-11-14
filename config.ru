require 'sinatra/base'

# controllers
require './controllers/ApplicationController'

# models will go here

# map out the routes
map('/') {
  run ApplicationController
}