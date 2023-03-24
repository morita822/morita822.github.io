class SalariesController < ApplicationController
  def index
    @salaries = Salary.all
    @employees = Employee.all
  end
  
  def calculate_salaries
    base_rate = session[:base_rate] || 1000 
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    
    Employee.all.each do |employee|
      employee.calculate_salary(start_date, end_date)
    end
    
    redirect_to salaries_path, notice: '給与が計算されました'
  end

  def edit_base_rate
    @base_rate = session[:base_rate] || 1000
  end

  def update_base_rate
    session[:base_rate] = params[:base_rate].to_i
    redirect_to salaries_path
  end
end
