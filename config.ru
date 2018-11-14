require 'sinatra/base'

# controllers
require './controllers/ApplicationController'

# models will go here
require './models/ItemModel'

# map out the routes
map('/') {
  run ApplicationController
}