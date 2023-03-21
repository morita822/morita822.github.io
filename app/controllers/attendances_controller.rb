class AttendancesController < ApplicationController
  before_action :set_user
  before_action :set_attendance, only: [:edit, :update, :approve]

  def index
    @attendances = @empoyee.attendances.on_this_month.order(:worked_on)
  end

  def new
    @attendance = @empoyee.attendances.build(worked_on: Date.current)
  end

  def create
    @attendance = @empoyee.attendances.build(attendance_params)
    if @attendance.save
      redirect_to user_attendances_path(@empoyee), notice: '出勤時刻を登録しました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @attendance.update(attendance_params)
      redirect_to user_attendances_path(@empoyee), notice: '勤怠情報を更新しました。'
    else
      render :edit
    end
  end

  def approve
    @attendance.update(approved_at: Time.current)
    redirect_to user_attendances_path(@empoyee), notice: '承認しました。'
  end

  private

  def set_employee
    @empoyee = Empoyee.find(params[:empoyee_id])
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:status, :worked_on, :note)
  end
end

  