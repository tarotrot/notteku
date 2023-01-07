class BookingsController < ApplicationController
  before_action :login_required

  # 予約一覧
  def index
    @bookings = Booking.where(user_id: current_user.id).order(params[:id])#.page(params[:page]).per(15)
  end

  # 予約情報の詳細
  def show
    @booking = Booking.find(params[:id])
  end

  # 予約情報編集フォーム
  def edit
    @booking = Booking.find(params[:id])
  end

  # 予約情報の更新
  def update
    @booking = Booking.find(params[:id])
    @booking.assign_attributes(booking_params)
    if @booking.save
      redirect_to :bookings, notice: "予約情報を更新しました。"
    else
      render "edit"
    end
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to root_path, notice: "予約を登録しました。"
    else
      render "new"
    end
  end

  # ストロング・パラメータ
  private def booking_params
    params.require(:booking).permit(
      :status
    )
  end
end
