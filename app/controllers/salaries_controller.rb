class SalariesController < ApplicationController
    before_action :set_salary, only: %i[show edit update destroy]
  
    def index
      @salaries = Salary.all
    end
  
    def show
    end
  
    def new
      @salary = Salary.new
    end
  
    def create
      @salary = Salary.new(salary_params)
  
      if @salary.save
        redirect_to @salary, notice: 'Salary was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @salary.update(salary_params)
        redirect_to @salary, notice: 'Salary was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @salary.destroy
      redirect_to salaries_url, notice: 'Salary was successfully destroyed.'
    end
  
    private
  
    def set_salary
      @salary = Salary.find(params[:id])
    end
  
    def salary_params
      params.require(:salary).permit(:employee_id, :basic_salary, :overtime_salary)
    end
  end
  