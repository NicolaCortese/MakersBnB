# frozen_string_literal: true

require 'date'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/user'
require './lib/space'
require './lib/booking'

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
    flash[:notice] = 'Successfully logged out'
    redirect '/'
  end

  get '/login' do
    erb :login
  end

  post '/logging-in' do
    @user = User.find_by(username: params[:username])
    if @user.nil?
      flash[:notice] = 'No such username'
      redirect '/login'
    elsif @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:notice] = 'Your password is incorrect'
      redirect '/login'
    end
  end

  post '/booking/:id' do
    @booking = Booking.create(
      user_id: session[:user_id],
      space_id: params[:id]
    )
    @booking.save

    flash[:notice] = 'Booking successfull!'
    redirect '/'
  end

  get '/listing/:id' do
    @space = Space.find_by_id(params[:id])
    erb :listing
  end

  get '/new-space' do
    @today = Date.today.strftime("%Y-%m-%d")
    @tomorrow = Date.tomorrow.strftime("%Y-%m-%d")
    erb(:list_space)
  end

  get '/my-spaces' do
    @user = User.find_by_id(session[:user_id])
    @space = Space.where("user_id = #{session[:user_id]}")
    erb(:my_spaces)
  end

  get '/edit-space/:space_id' do
    
    @space = Space.find_by_id(params[:space_id])
    @today = Date.today.strftime("%Y-%m-%d")
    @tomorrow = Date.tomorrow.strftime("%Y-%m-%d")
    @current_start_date = @space.availability_from
    @current_end_date = @space.availability_to
    erb(:edit_space)
  end

  post '/edit-space/:space_id' do
    @start_date = params[:availability_from].to_date
    @end_date = params[:availability_to].to_date

    if @end_date <= @start_date
      flash[:notice]= "Your end date cannot be before your start date. Please try again."
      redirect "/edit-space/#{params[:space_id]}"

    else
      Space.update(
      params[:space_id], 
      space_name: params[:space_name],
      description: params[:description],
      price: params[:price],
      availability_from: params[:availability_from],
      availability_to: params[:availability_to]
      )
      
      flash[:notice]= "Space has been successfully edited"
      redirect '/my-spaces'
    end
  end
  
  post '/delete-space/:space_id' do
    Space.delete(params[:space_id])
    flash[:notice]= "Space has been successfully deleted"
    redirect '/my-spaces'
  end

  post '/listing-space' do 
    @space = Space.new(
      space_name: params[:space_name],
      description: params[:description],
      price: params[:price],
      availability_from: params[:availability_from],
      availability_to: params[:availability_to],
      user_id: session[:user_id]
    )
    @start_date = @space.availability_from.to_date
    @end_date = @space.availability_to.to_date

    if @end_date <= @start_date
      flash[:notice]= "Your end date cannot be before your start date. Please try again."
      redirect '/new-space'
    else
      @space.save
      redirect '/'
    end
  end

  get '/requests' do
    @bookings = Booking.all
    @user_bookings = @bookings.where(user_id: session[:user_id])
    @user_spaces = Space.where(user_id: session[:user_id])
    @user_requests = @bookings.where(space_id: @user_spaces)
    
    erb :requests
  end

  run! if app_file == $PROGRAM_NAME
end
