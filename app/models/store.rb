class Store < ApplicationRecord
  has_many :bookings
  has_many :cars
end
