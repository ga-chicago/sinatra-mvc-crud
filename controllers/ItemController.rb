# all other controllers inherit from ApplicationController
class ItemController < ApplicationController
  # index
  get '/' do
    # get all the items
    # pass them to template
    @items = Item.all # this would be like Item.find({}) in mongoose

    erb :item_index
  end

  # new -- show form to add
  get '/new' do
    erb :item_new
  end

  # create 
  post '/' do
    pp params[:content]

    item = Item.new
    puts "here comes a new item where we haven't set any values yet"
    pp item

    item.content = params[:content]

    item.save # this actually runs the SQL insert query

    redirect '/items' # send them back to items index

  end 

end