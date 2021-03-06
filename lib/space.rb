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

class Space < ActiveRecord::Base
  validates :space_name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  belongs_to :user
  has_many :bookings, dependent: :destroy
  # validates :availability_from
  # validates :availability_to
end
