# all other controllers inherit from ApplicationController
class ItemController < ApplicationController

  # this is called a filter -- it wil be run on all routes
  # you can customize it to only run on certain routes

  # before do
  #   if !session[:logged_in]
  #     session[:message] = {
  #       status: "neutral",
  #       text: "You must be logged in to do that"
  #     }
  #     redirect '/user/login'
  #   end
  # end


  # index
  get '/' do
    # get all the items
    # pass them to template
    # @items = Item.all # this would be like Item.find({}) in mongoose

    # get DB  record corresponding to the username in session
    user = User.find_by username: session[:username]

    @items = user.items # pretty sweet amirite
    
    erb :item_index
  end

  # api index 
  get '/api' do # get '/items/api'
    # Using a model made with ActiveRecord ORM to query the db
    # .find_by is a query method
    username = "reuben"
    user = User.find_by username: username

    # writing our response
    {
      status: 200,
      items: user.items
    }.to_json

  end

  # new -- show form to add
  get '/new' do
    erb :item_new
  end

  # create 
  post '/' do
    # get the user from DB corresponding to username in session
    logged_in_user = User.find_by username: session[:username]

    item = Item.new

    item.content = params[:content]
    item.user_id = logged_in_user.id

    item.save # this actually runs the SQL insert query

    session[:message] = {
      status: "good",
      text: "Succesfully created item #{item.id}"
    }

    redirect '/items' # send them back to items index

  end 

  # edit
  get '/:id/edit' do
    @item = Item.find params[:id] # querying a DB using ActiveRecord ORM
                                  # Object Relational Mapper
    erb :item_edit
  end

  # update
  put '/:id' do
    item = Item.find params[:id]
    item.content = params[:content]
    item.save
    session[:message] = {
      status: "good",
      text: "Succesfully updated item #{item.id}"
    }
    redirect '/items'
  end
  
  # destroy
  delete '/:id' do
    # pp params
    item = Item.find params[:id] # this runs an SQL SELECT query

    item.destroy # this will run the SQL DELETE query
    session[:message] = {
      status: "good",
      text: "Succesfully deleted item #{item.id}"
    }
    redirect '/items'

  end

end