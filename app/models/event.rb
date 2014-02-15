class Event < ActiveRecord::Base

  #belongs_to :user, foreign_key: :owner_id
  belongs_to :owner, class_name: :User

  validates :owner_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validate :validate_datetime

  def validate_datetime
    # errors.add(:start_time, 'must be a valid datetime') if ((Time.parse(:start_time) rescue ArgumentError) == ArgumentError)
    # errors.add(:end_time, 'must be a valid datetime') if ((Time.parse(:end_time) rescue ArgumentError) == ArgumentError)
  end


end
