# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/user'

class Makersbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash
  enable :sessions

  get '/' do
    erb :index
  end

  post '/sign-up' do
    @user = User.create(
      email: params[:email],
      password: params[:password],
      username: params[:username],
      name: params[:name]
    )
    @user.save
    redirect '/listings'
  end

  run! if app_file == $PROGRAM_NAME
end
