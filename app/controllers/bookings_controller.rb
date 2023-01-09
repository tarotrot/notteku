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
    code = Booking.all.count
    @booking = Booking.new(
      booking_code: code + 1,
      user: current_user,
      status: "貸出前",
      rental_store: Store.find_by(id: params[:booking][:rental_store].to_i),
      return_store: Store.find_by(id: params[:booking][:return_store].to_i),
      rental_start: params[:booking][:rental_start],
      rental_end: params[:booking][:rental_end],
      car: Car.find_by(id: params[:booking][:car]),
      total_price: 1
    )
    render "confirm"
  end

  def create
    # @booking = Booking.new(booking_params)
    code = Booking.all.count
    @car = Car.find_by(id: params[:booking][:car].to_i)
    @booking = Booking.new(
      booking_code: code + 1,
      user: current_user,
      status: "貸出前",
      rental_store: Store.find_by(id: params[:booking][:rental_store].to_i),
      return_store: Store.find_by(id: params[:booking][:return_store].to_i),
      rental_start: params[:booking][:rental_start],
      rental_end: params[:booking][:rental_end],
      car: @car,
      total_price: params[:booking][:total_price].to_i
    )
    @car.assign_attributes(status: "準備中")
    if @booking.save && @car.save
      redirect_to root_path, notice: "予約を登録しました。"
    else
      redirect_to root_path, notice: "失敗しました。"
    end
  end

  # ストロング・パラメータ
  private def booking_params
    params.require(:booking).permit(
      :status
    )
  end
end
