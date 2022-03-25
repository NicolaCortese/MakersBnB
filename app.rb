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
    @today = Date.today
    @tomorrow = Date.tomorrow
    @available_spaces = session[:available_spaces]
    erb :index
  end

  post '/spaces-by-date' do
    @requested_dates = (params[:search_from].to_date..params[:search_to].to_date).to_a
    @available_spaces = Space.pluck(:id)
    Booking.where(accepted: true).each do |booking|
      @taken_dates = (booking.booked_from.to_date..booking.booked_to.to_date).to_a
      conflict = false
      @requested_dates.each do |date|
        if @taken_dates.include?(date)
          conflict = true
        end
      end
      if conflict == true
        @available_spaces.delete(booking.space_id)
      end
    end

    session[:available_spaces] = @available_spaces

    redirect '/'
  end

  post '/clear-search' do
    session.delete(:available_spaces)
    redirect '/'
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
    @booking = Booking.new(
      user_id: session[:user_id],
      space_id: params[:id],
      booked_from: params[:booked_from],
      booked_to: params[:booked_to]
    )
    conflict = false
    @requested_dates = (params[:booked_from].to_date..params[:booked_to].to_date).to_a
    Booking.where(space_id: params[:id], accepted: true).each do |booking|
      @taken_dates = (booking.booked_from.to_date..booking.booked_to.to_date).to_a
      @requested_dates.each do |date|
        if @taken_dates.include?(date)
          conflict = true
        end
      end
    end

    if conflict
      flash[:notice] = 'This space is not available on those dates'
      redirect "/listing/#{params[:id]}"
    else 
      flash[:notice] = 'Booking successfull!'
      @booking.save
      redirect '/'
    end
    
  end

  get '/listing/:id' do
    @space = Space.find_by_id(params[:id])
    @total_availability = (@space.availability_from.to_date..@space.availability_to.to_date).to_a

    Booking.where(space_id: params[:id], accepted: true).each do |booking|
      (booking.booked_from.to_date..booking.booked_to.to_date).to_a.each do |date|
        @total_availability.delete(date)
      end
    end
    
    @owner_username = User.find_by_id(@space.user_id).username
    
    @start_date = @space.availability_from
    @end_date = @space.availability_to
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

    if params[:space_name] == "" || params[:description] == "" || params[:price] == ""
      flash[:notice]= "Please complete all fields to list your space"
      redirect '/new-space'
    elsif @end_date <= @start_date
      flash[:notice]= "Your end date cannot be before your start date. Please try again."
      redirect '/new-space'
    else
      @space.save
      redirect '/'
    end
  end

  get '/requests' do
    @user_bookings = Booking.where(user_id: session[:user_id])
    @user_spaces = Space.where(user_id: session[:user_id])
    @user_requests = Booking.where(space_id: @user_spaces)
    
    erb :requests
  end
  
  post '/accept-or-reject/:booking_id' do
    if params[:outcome] == "Accept"
      Booking.update(params[:booking_id], accepted: true)
      @accepted_request = Booking.find_by_id(params[:booking_id])
      @user_spaces = Space.where(user_id: session[:user_id])
      @user_requests = Booking.where(space_id: @user_spaces)
      @user_requests.each do |request|
        if request.accepted == nil && request.booked_from == @accepted_request.booked_from
          Booking.update(request.id, accepted: false)
        end
      end
    else
      Booking.update(params[:booking_id], accepted: false)
    end
    redirect '/requests'
  end

  get '/settings' do
    erb :settings
  end

  post '/delete-account' do
    User.delete(session[:user_id])
    session.clear
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
