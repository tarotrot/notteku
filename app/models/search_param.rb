class SearchParam
  include ActiveModel::Model

  # attr_accessor :name
  # validates :name, presence: true

  attr_accessor :rental_start
  attr_accessor :rental_end
  validate :start_finish_check

  def start_finish_check
      errors.add(:rental_end, "は開始時刻より遅い時間を選択してください") if self.rental_start >= self.rental_end
  end
end
