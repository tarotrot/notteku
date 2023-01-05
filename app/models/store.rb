class Store < ApplicationRecord
  has_many :bookings
  has_many :cars, dependent: :destroy

  validates :store_code, presence: true,
    format: { with: /\A[a-zA-Z0-9]+\z/, allow_blank: true },
    length: { maximum: 19, allow_blank: true },
    uniqueness: { case_sensitive: false }

  validates :name, presence: true,
    length: { maximum: 19, allow_blank: true },
    uniqueness: { case_sensitive: false }

  validate :name_check
  validate :start_finish_check

  def name_check
    if self.name =~ /^[A-Za-z0-9]+$/
      errors.add(:name, "は英数字のみでは登録できません")
    end
  end

  validates :address, presence: true,
    length: { maximum: 99, allow_blank: true }

  validates:phone_number, presence: true,
    format: { with: /\A[0-9()-][0-9()-]*\z/, allow_blank: false },
    length: { maximum: 19 },
    uniqueness: { case_sensitive: false }

  def start_finish_check
    errors.add(:end_time, "は開始時刻より遅い時間を選択してください") if self.start_time > self.end_time
  end
end
