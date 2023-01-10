class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car
  belongs_to :rental_store, class_name: "Store", foreign_key: "rental_store_id", optional: true
  belongs_to :return_store, class_name: "Store", foreign_key: "return_store_id", optional: true
end
