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
    extant_user = User.find_by :username => params[:username]
    if extant_user
      session[:message] = {
        status: "bad",
        text: "Username #{params[:username]} already taken"
      }
      redirect '/user/register'
    else

      user = User.new 
      user.username = params[:username]
      # adding has_secure password to the model makes this 
      # use bcrypt
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

  end # post '/register'

  # log in
  post '/login' do
    # find the user with username from params
    user = User.find_by(:username => params[:username])

    pw = params[:password]

    # check password
    # if it's good 
    if user and user.authenticate(pw)
      # session stuff -- tell app user logged in
      session[:logged_in] = true
      session[:username] = user.username
      session[:message] = {
        status: "good",
        text: "User #{user.username} successfully logged in, Welcome back"
      }
      redirect '/items'
    # if it's bad
    else
      # error message
      session[:message] = {
        status: "bad",
        text: "Invalid username or password."
      }
      # send back to login
      redirect '/user/login'
    end

  end # post 'login'


  post '/api/login' do # get '/users/api/login'

    # we need to do this to receive JSON in a request
    payload_body = request.body.read
    payload = JSON.parse(payload_body).symbolize_keys
    
    user = User.find_by username: payload[:username]
    pw = payload[:password]

    if user and user.authenticate pw
      session[:logged_in] = true
      session[:username] = user.username
      {
        status: 200,
        message: "Login successful",
        logged_in_as: user.username
      }.to_json
    else
      {
        status: 403,
        message: "Invalid username or password"
      }.to_json
    end

  end # post '/api/login' 


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