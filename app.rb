# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/user'
require './lib/space'

class Makersbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash
  enable :sessions

  get '/' do
    @user = User.find_by_id(session[:user_id])
    @space = Space.all
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
    session[:user_id] = @user.id
    redirect '/'
  end

  post '/log-out' do
    session.clear
    flash[:notice]= "Successfully logged out"
    redirect '/'
  end

  get '/login' do
    erb :login
  end

  post '/logging-in' do
    @user = User.find_by(username: params[:username])
    if @user.nil?
      flash[:notice]= "No such username"
      redirect '/login'
    elsif @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:notice]= "Your password is incorrect"
      redirect  '/login'
    end
  end
  
  post '/booking/:id' do
    @booking = Booking.create(
      user_id: session[:user_id], 
      space_id: params[:id]
    )
    @booking.save
      
    flash[:notice]= "Booking successfull!"
    redirect '/'
  end

  get '/listing/:id' do
    @space = Space.find_by_id(params[:id])
    erb :listing
  end 

  get '/new-space' do
    erb(:list_space)
  end

  post '/listing-space' do 
    @space = Space.create(
      space_name: params[:space_name],
      description: params[:description],
      price: params[:price],
      availability_from: params[:availability_from],
      availability_to: params[:availability_to],
      user_id: session[:user_id]
    )
    @space.save 
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
