class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car
  belongs_to :store
  # belongs_to :store, foreign_key: "rental_store_id"
  # belongs_to :store, foreign_key: "return_store_id"
end
