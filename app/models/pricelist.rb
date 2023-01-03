class Pricelist < ApplicationRecord
  validates :name, presence: true
  validates :basic_price, presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      allow_blank: true
    }
  validates :season_start, presence: true
  validates :season_end, presence: true

  validate :start_finish_check

  def start_finish_check
    errors.add(:season_end, "は開始時刻より遅い時間を選択してください") if self.season_start > self.season_end
  end
end
