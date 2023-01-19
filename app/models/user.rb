class User < ApplicationRecord
  has_secure_password

  has_many :bookings, dependent: :destroy

  validates :name, presence: true,
    length: { maximum: 19, allow_blank: true }
  validates :birthday, date: { before: Time.current.to_date + 1 }
  validates:phone, presence: true,
    format: { with: /\A[0-9()-][0-9()-]*\z/, allow_blank: true },
    length: { maximum: 19 }
  validates :email, presence:true, email: { allow_blank: true },
    uniqueness: { case_sensitive: false }

  attr_accessor :current_password
  validates :password, presence: { if: :current_password },
    length: { minimum: 9, allow_blank: true }
end
