class AttendancesController < ApplicationController
  before_action :set_employee, only: [:index, :show, :edit, :update, :destroy, :new, :create]
  before_action :set_attendance, only: [:edit, :update, :approve]

  def index
    @attendance = @employee.attendances.on_this_month.order(:date)
  end

  def show
  end

  def new
    @attendance = @employee.attendances.build(date: Date.current)
  end

  def create
    @attendance = @employee.attendances.build(attendance_params)
    if @attendance.save
      redirect_to employee_attendances_path(@employee), notice: '出勤時刻を登録しました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @attendance.update(attendance_params)
      redirect_to employee_attendances_path(@employee), notice: '勤怠情報を更新しました。'
    else
      render :edit
    end
  end

  def approve
    @attendance.update(approved_at: Time.current)
    redirect_to employee_attendances_path(@employee), notice: '承認しました。'
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:employee_id])
  end


  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

end