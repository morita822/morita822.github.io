class Employee < ApplicationRecord
  has_many :attendances
  has_many :shifts, dependent: :destroy
  has_many :salaries, dependent: :destroy

  def calculate_salary(start_date, end_date)
    # 勤怠から労働時間を計算
    worked_hours = attendances.where('date >= ? AND date <= ?', start_date, end_date).sum(:worked_hours)

    # シフトから支払われる給与を計算
    shift_pay = shifts.where('date >= ? AND date <= ?', start_date, end_date).sum(:pay)

    # 給与を計算
    total_salary = (worked_hours * hourly_rate) + shift_pay

    # salariesテーブルを更新
    salary.update!(amount: total_salary, start_date: start_date, end_date: end_date)
  end
end
