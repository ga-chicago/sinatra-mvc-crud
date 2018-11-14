# all other controllers inherit from ApplicationController
class ItemController < ApplicationController
  get '/test' do
    "you hit item controller"
  end
end