class Admin::BookingsController < Admin::Base
  # 予約一覧
  def index
    @bookings = Booking.order(params[:id]).page(params[:page]).per(15)
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
      redirect_to :admin_bookings, notice: "予約情報を更新しました。"
    else
      render "edit"
    end
  end

  # ストロング・パラメータ
  private def booking_params
    params.require(:booking).permit(
      :status
    )
  end
end
