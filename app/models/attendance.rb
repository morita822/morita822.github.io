class Attendance < ApplicationRecord
  belongs_to :employee

  enum attendance_status: { check_in: 1, check_out: 0 }

  validates :date, presence: true
  validates :attendance_status, presence: true
  

  scope :on_this_month, -> { where(date: Time.current.all_month) }
  scope :approved, -> { where.not(approved_at: nil) }
end
