# frozen_string_literal: true

require 'active_record'

if ENV['ENVIRONMENT'] == 'test'
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    host: 'localhost',
    username: ENV['USERNAME'],
    password: ENV['SQL_PASSWORD'],
    database: 'makersbnb_test'
  )
else
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    host: 'localhost',
    username: ENV['USERNAME'],
    password: ENV['SQL_PASSWORD'],
    database: 'makersbnb'
  )
end

class Booking < ActiveRecord::Base
  validates :space_id, presence: true
  validates :user_id, presence: true
  validates :booked_from, presence: true
  # validates :booked_to
end
