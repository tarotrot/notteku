class Car < ApplicationRecord
  belongs_to :store
  has_many :bookings

  validates :price, presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      allow_blank: true
    }
end
