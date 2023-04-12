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
      base_rate = 1000 # これは基本時給を設定する箇所です。必要に応じて変更してください。
      salary = 0
      employee.shifts.each do |shift|
        hours = (shift.end_time - shift.start_time) / 3600
        if hours > 8
          salary += 8 * base_rate
          salary += (hours - 8) * base_rate * 1.25
        else
          salary += hours * base_rate
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
      salary = employee.salaries.where('created_at >= ? AND created_at <= ?', @shift.date.beginning_of_month, @shift.date.end_of_month).first
  
      if salary.nil?
        salary = employee.salaries.create!(employee_id: employee.id, basic_salary: 0, overtime_salary: 0)
      end
  
      salary = calculate_salaries(@shift.employee)
      salary.save!
  
      redirect_to shifts_path, notice: 'Shift was successfully created.'
    else
      render :new
    end
  end
  
  def calculate_salaries(employee)
    base_rate = 1000 
    hours = employee.shifts.where(date: @shift.date.beginning_of_month..@shift.date.end_of_month).sum { |shift| shift.end_time - shift.start_time }
    overtime = [hours - 8, 0].max
    regular_hours = hours - overtime
    salary = employee.salaries.find_by('created_at >= ? AND created_at <= ?', @shift.date.beginning_of_month, @shift.date.end_of_month)
    salary ||= employee.salaries.create!(employee_id: employee.id, basic_salary: 0, overtime_salary: 0)
    salary.basic_salary = regular_hours * base_rate
    salary.overtime_salary = overtime * base_rate * 1.25
    salary.save!
    salary
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
end
