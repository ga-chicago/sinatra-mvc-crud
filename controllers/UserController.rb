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
    params.to_json # since JSON is a string, this will work
                    # as an implicit/automatic return
  end

  # log in
  post '/login' do
    params.to_json
  end

  # log out
  get '/logout' do
    # session[:message] = {
    #   :status => "neutral",
    #   :text => "You just tried to log out"
    # }
    # redirect '/login'
    "logout"
  end

end