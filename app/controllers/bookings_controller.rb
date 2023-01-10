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
    if @booking.status == "キャンセル" || @booking.rental_start <= Time.now + 2.hours
      redirect_to :bookings, notice: "予約変更できません"
    end
  end

  # 予約情報の更新
  def update
    @booking = Booking.find(params[:id])
    @booking.assign_attributes(booking_params)
    store = Store.find_by(id: params[:return_store].to_i)
    @booking.assign_attributes(return_store: store)
    if @booking.save
      redirect_to :bookings, notice: "予約情報を更新しました。"
    else
      render "edit"
    end
  end

  def new
    code = Booking.all.count
    car_and_price = params[:booking][:car].split
    car = Car.find_by(id: car_and_price[0].to_i)
    @rental_store = Store.find_by(id: params[:booking][:rental_store].to_i)
    @return_store = Store.find_by(id: params[:booking][:return_store].to_i)
    if car.nil?
      redirect_to root_path, notice: "車が見つかりません。"
    elsif @rental_store.nil? || @return_store.nil?
      redirect_to root_path, notice: "店舗が見つかりません。"
    else
      price = car_and_price[1]
      puts car.name
      puts price
      @booking = Booking.new(
        booking_code: code + 1,
        user: current_user,
        status: "貸出前",
        rental_store: @rental_store,
        return_store: @return_store,
        rental_start: params[:booking][:rental_start],
        rental_end: params[:booking][:rental_end],
        car: car,
        total_price: price
      )
      render "confirm"
    end
  end

  def create
    @booking = Booking.new(booking_params)
    code = Booking.all.count
    @car = Car.find_by(id: params[:booking][:car].to_i)
    @rental_store = Store.find_by(id: params[:booking][:rental_store].to_i)
    @return_store = Store.find_by(id: params[:booking][:return_store].to_i)
    if @car.nil?
      redirect_to root_path, notice: "車が見つかりません"
    elsif @car.status != "予約可能"
      redirect_to root_path, notice: "この車は予約できません"
    elsif @rental_store.nil? || @return_store.nil?
      redirect_to root_path, notice: "店舗が見つかりません"
    else
      @booking = Booking.new(
        booking_code: code + 1,
        user: current_user,
        status: "貸出前",
        rental_store: @rental_store,
        return_store: @return_store,
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
  end

  # ストロング・パラメータ
  private def booking_params
    params.require(:booking).permit(
      :return_store_id,
      :rental_start,
      :rental_end,
      :status
    )
  end
end
