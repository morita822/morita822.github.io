class ShiftsController < ApplicationController
  before_action :set_shift, only: %i[show edit update destroy]

  
  def index
    @shifts = Shift.all
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @shifts_by_date = @shifts.group_by { |shift| shift.date }
    
    # @employees と @salaries を設定
    @employees = Employee.all
    @salaries = {}
    @employees.each do |employee|
      base_hourly_rate = 1000 # これは基本時給を設定する箇所です。必要に応じて変更してください。
      salary = 0
      employee.shifts.each do |shift|
        hours = (shift.end_time - shift.start_time) / 3600
        if hours > 8
          salary += 8 * base_hourly_rate
          salary += (hours - 8) * base_hourly_rate * 1.25
        else
          salary += hours * base_hourly_rate
        end
      end
      @salaries[employee.id] = salary
    end
  end
  
    


  def show
  end

  def new
    @shift = Shift.new
  end



  def create
    @shift = Shift.new(shift_params)

    if @shift.save
      employee = @shift.employee
      salary = employee.salaries.find_by('created_at >= ? AND created_at <= ?', @shift.date.beginning_of_month, @shift.date.end_of_month)

      if salary.nil?
        salary = employee.salaries.create!(employee_id: employee.id, basic_salary: 0, overtime_salary: 0)
      end

      salary = calculate_salary(salary, @shift)
      salary.save!

      redirect_to shifts_path, notice: 'Shift was successfully created.'
    else
      render :new
    end
  end


  def edit
  end

  def update
    if @shift.update(shift_params)
      redirect_to @shift, notice: 'Shift was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @shift.destroy
    redirect_to shifts_url, notice: 'Shift was successfully destroyed.'
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:employee_id, :date, :start_time, :end_time)
  end

  def calculate_salaries
    base_rate = 1000 
    salaries = {}
    @shifts.each do |shift|
      hours = shift.end_time - shift.start_time
      overtime = [hours - 8, 0].max
      regular_hours = hours - overtime
      employee_id = shift.employee_id

      salaries[employee_id] ||= 0
      salaries[employee_id] += (regular_hours * base_rate) + (overtime * base_rate * 1.25)
    end
    salaries
  end
end
