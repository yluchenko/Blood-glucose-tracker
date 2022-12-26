class Reading < ApplicationRecord
  belongs_to :user
  validates :level, presence: true, level: true
  validates_length_of :level, maximum: 1
  validates_numericality_of :level, only_integer: true
  attr_accessor :reading_count

  scope :today, -> { where('created_at > ?', Time.current.beginning_of_day) }
  scope :monthly, -> { where('created_at > ?', 1.month.ago) }
  scope :month_to_date, ->(data) { where('created_at > ? and created_at <= ?', Time.current.beginning_of_month, data) }
  scope :reading_count_of_day, -> { today.count }
  before_validation :set_reading_count

  def set_reading_count
    count = User.find_by(id: user_id).readings.reading_count_of_day if user_id.present?
    self.reading_count = count || 0
  end

  def full_error_message
    errors.full_messages.to_sentence.capitalize
  end
end
