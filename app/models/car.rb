class Car < ApplicationRecord
  class << self
    def search(query)
      rel = order("id")
      if query.present?
        # rel = rel.where("name LIKE ? OR full_name LIKE ?",
        #   "%#{query}%", "%#{query}%")
        rel = rel.where("name LIKE ?", "%#{query}%")
      end
      rel
    end
  end

  belongs_to :store
  has_many :bookings

  validates :price, presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      allow_blank: true
    }
end
