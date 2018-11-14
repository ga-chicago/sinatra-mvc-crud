# all other controllers inherit from ApplicationController
class ItemController < ApplicationController
  # index
  get '/' do
    # get all the items
    # pass them to template
    @items = Item.all # this would be like Item.find({}) in mongoose

    erb :item_index
  end
end