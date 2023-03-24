class AttendancesController < ApplicationController
  before_action :set_employee, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_attendance, only: [:edit, :update, :approve]

  def index
    @attendances = @employee.attendances.on_this_month.order(:worked_on)
  end

  def show
  end

  def new
    @attendance = @employee.attendances.build(worked_on: Date.current)
  end

  def create
    @attendance = @employee.attendances.build(attendance_params)
    if @attendance.save
      redirect_to user_attendances_path(@employee), notice: '出勤時刻を登録しました。'
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
    @employee = Employee.find(params[:employee_id])
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:status, :worked_on, :note)
  end
end

<%= link_to "Attendance List", employee_attendances_path(@employee) %>


  