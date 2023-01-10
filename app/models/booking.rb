class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car
  belongs_to :rental_store, class_name: "Store", foreign_key: "rental_store_id", optional: true
  belongs_to :return_store, class_name: "Store", foreign_key: "return_store_id", optional: true

  validate :start_finish_check

  def start_finish_check
      errors.add(:rental_end, "は開始時刻より遅い時間を選択してください") if self.rental_start >= self.rental_end
  end
end
