class Attendance < ApplicationRecord
    belongs_to :employee
  
    enum status: { check_in: 1, check_out: 2 }
  
    validates :status, presence: true
    validates :worked_on, presence: true
  
    scope :on_this_month, -> { where(worked_on: Time.current.all_month) }
    scope :approved, -> { where.not(approved_at: nil) }
  end
  