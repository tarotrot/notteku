class CarsController < ApplicationController
  def index
  end

  def search
   @cars = Car.search(params[:name])
   @cars = @cars.where(store: params[:rental_store])
   @cars = @cars.where(status: "予約可能")
   @cars = @cars.where(car_type: params[:car_type])
   rental_start_month = ten_digit(params[:rental_start]["(2i)"])
   rental_start_day = ten_digit(params[:rental_start]["(3i)"])
   @rental_start_datetime = params[:rental_start]["(1i)"] + "-" + rental_start_month.to_s + "-" + rental_start_day.to_s + "-" + params[:rental_start]["(4i)"] + ":" + params[:rental_start]["(5i)"]
   rental_end_month = ten_digit(params[:rental_end]["(2i)"])
   rental_end_day = ten_digit(params[:rental_end]["(3i)"])
   @rental_end_datetime = params[:rental_end]["(1i)"] + "-" + rental_end_month.to_s + "-" + rental_end_day.to_s + "-" + params[:rental_end]["(4i)"] + ":" + params[:rental_end]["(5i)"]
   @rental_store = Store.find_by(id: params[:rental_store])
   @return_store = Store.find_by(id: params[:return_store])
   @booking = Booking.new(
     rental_store: @rental_store,
     return_store: @return_store,
     rental_start: @rental_start_datetime,
     rental_end: @rental_end_datetime
   )
   render "index"
  end

  def ten_digit(time)
    if time.to_i < 10
      time = "0" + time.to_s
    end
    time.to_s
  end

  def permit_params
    @attr = params.permit(
      :rental_store_id,
      :return_store_id,
      :rental_start,
      :rental_end
    )
  end
end
