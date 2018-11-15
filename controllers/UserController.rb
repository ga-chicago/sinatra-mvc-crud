class UserController < ApplicationController

  # show login form
  get '/login' do
    erb :login
  end

  # show registration form
  get '/register' do
    erb :register
  end

  # register
  post '/register' do
    # to send json, you must already have a hash
    # .to_json will convert it to JSON
    # remember JSON, once serialized, IS A STRING
    # params.to_json # since JSON is a string, this will work
                    # as an implicit/automatic return
    user = User.new 
    user.username = params[:username]
    user.password = params[:password]
    user.save
    session[:logged_in] = true
    session[:username] = user.username
    session[:message] = {
      status: "good",
      text: "User #{user.username} successfully created"
    }
    redirect '/items'

  end

  # log in
  post '/login' do
    params.to_json
  end

  # log out
  get '/logout' do
    username = session[:username]
    session.destroy    
    session[:message] = {
      :status => "neutral",
      :text => "User #{username} logged out."
    }
    redirect '/user/login'

  end

end