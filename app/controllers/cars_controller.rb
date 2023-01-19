class CarsController < ApplicationController
  def index
  end

  def search
    @cars = Car.search(params[:name])
    @cars = @cars.where(store: params[:rental_store])
    @cars = @cars.where(status: "予約可能")
    @cars = @cars.where(car_type: params[:car_type]).page(params[:page]).per(15)
    rental_start_month = ten_digit(params[:rental_start]["(2i)"])
    rental_start_day = ten_digit(params[:rental_start]["(3i)"])
    rental_end_month = ten_digit(params[:rental_end]["(2i)"])
    rental_end_day = ten_digit(params[:rental_end]["(3i)"])
    @rental_store = Store.find_by(id: params[:rental_store])
    @return_store = Store.find_by(id: params[:return_store])
    @rental_start_datetime = params[:rental_start]["(1i)"] + "-" + rental_start_month.to_s + "-" + rental_start_day.to_s + "-" + params[:rental_start]["(4i)"] + ":" + params[:rental_start]["(5i)"]+ " +0900"
    @rental_end_datetime = params[:rental_end]["(1i)"] + "-" + rental_end_month.to_s + "-" + rental_end_day.to_s + "-" + params[:rental_end]["(4i)"] + ":" + params[:rental_end]["(5i)"]+ " +0900"
    search_param = SearchParam.new(rental_start: @rental_start_datetime, rental_end: @rental_end_datetime)
    start_time = (Time.parse( @rental_start_datetime)).floor# レンタル開始時間
    end_time = (Time.parse(@rental_end_datetime)).floor# レンタル終了時間
    rental_start_time = start_time.strftime('%H%M').to_i
    rental_end_time = end_time.strftime('%H%M').to_i
    store_start_time = @rental_store.start_time.strftime('%H%M').to_i
    store_end_time = @return_store.end_time.strftime('%H%M').to_i
    if @cars.nil?
      redirect_to root_path, notice: "該当する車が見つかりません。"
    elsif rental_start_time < store_start_time || store_end_time < rental_end_time
      redirect_to root_path, notice: "営業時間外です"
    elsif search_param.invalid?
      redirect_to root_path, notice: "レンタル開始は返却より前に設定してください"
    else
      @booking = Booking.new(
       rental_store: @rental_store,
       return_store: @return_store,
       rental_start: @rental_start_datetime,
       rental_end: @rental_end_datetime
      )
      time_elapsed = ((@booking.rental_end - @booking.rental_start) / 3600).ceil
      @total_price = {}
      price = Pricelist.find_by(name: "基本プラン").basic_price
      Car.all.each do |car|
       total = time_elapsed * (car.price + price) #すべて期間外の料金
       Pricelist.all.each do |pricelist|
         if pricelist.season_start != nil
           if pricelist.season_start <= @rental_start_datetime && @rental_end_datetime <= pricelist.season_end # "全部期間中"
             total = time_elapsed * (car.price + pricelist.basic_price)
             break
           elsif (@rental_start_datetime < pricelist.season_start) && (pricelist.season_end < @rental_end_datetime) # "期間をまたぐ"
             term = (pricelist.season_end.ceil_to(60.minutes) - pricelist.season_start.ceil_to(60.minutes)) / 3600 #期間内経過時間
             term_price = term * (car.price + pricelist.basic_price) #期間内料金
             out_of_term = ((pricelist.season_start.ceil_to(60.minutes) - start_time) + (end_time - pricelist.season_end.ceil_to(60.minutes))) / 3600 #期間外経過時間
             out_of_term_price = out_of_term * (car.price + price) #期間外料金
             total = out_of_term_price + term_price #合計金額
             break
           elsif (pricelist.season_start < @rental_start_datetime) && (@rental_start_datetime < pricelist.season_end) && (pricelist.season_end < @rental_end_datetime)  # "前半のみ期間中""
             term = (pricelist.season_end.ceil_to(60.minutes) - start_time) / 3600 #期間内経過時間
             term_price = term * (car.price + pricelist.basic_price) #期間内料金
             out_of_term = (end_time - pricelist.season_end.ceil_to(60.minutes)) / 3600 #期間外経過時間
             out_of_term_price = out_of_term * (car.price + price) #期間外料金
             total = out_of_term_price + term_price #合計金額
             break
           elsif (@rental_start_datetime < pricelist.season_start) && (pricelist.season_start < @rental_end_datetime) && (@rental_end_datetime < pricelist.season_end)  # "後半のみ期間中"
             out_of_term = (pricelist.season_start.ceil_to(60.minutes) - start_time) / 3600 #期間外経過時間
             out_of_term_price = out_of_term * (car.price + price) #期間外料金
             term = (end_time - pricelist.season_start.ceil_to(60.minutes)) / 3600 #期間内経過時間
             term_price = term * (car.price + pricelist.basic_price) #期間内料金
             total = out_of_term_price + term_price #合計金額
             break
           end
         end
       end
       @total_price[car.name] = total.to_i
     end
     render "index"
   end
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
