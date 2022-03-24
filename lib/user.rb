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

class User < ActiveRecord::Base
  has_secure_password
  has_many :spaces, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validates :password, presence: true
end
