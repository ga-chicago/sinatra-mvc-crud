require 'sinatra/base'

# controllers
require './controllers/ApplicationController'
require './controllers/ItemController'
require './controllers/UserController'

# models will go here
require './models/ItemModel'
require './models/UserModel'

# map out the routes
map('/') {
  run ApplicationController
}
map('/items') {
  run ItemController
}
map('/user') {
  run UserController
}