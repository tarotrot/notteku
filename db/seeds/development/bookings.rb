cars = ["ホンダ N-BOX", "トヨタ アクア", "フェラーリ ローマ", "スバル レヴォーグ", "ダイハツ　ハイゼットトラック", "トヨタ ヤリス"]
users = %w(Taro Jiro Hana John Taro Jiro)
rental_start = ["2023-07-31-19:00 +09:00", "2022-12-31-19:00 +09:00", "2022-03-01-11:00 +09:00", "2023-08-01-10:00 +09:00", "2022-03-01-12:00 +09:00", "2022-03-31-15:00 +09:00"]
rental_end = ["2023-08-01-10:00 +09:00", "2023-01-04-12:00 +09:00", "2022-03-01-17:00 +09:00", "2023-08-01-18:00 +09:00", "2022-03-03-19:00 +09:00", "2022-04-01-20:00 +09:00"]
status = ["貸出前", "返却完了", "返却完了"]
stores = ["生田店", "神田店", "神田店"]
price = Pricelist.find_by(name: "基本プラン").basic_price
total_price = 0
0.upto(5) do |idx|
  car = Car.find_by(name: cars[idx])
  rental_store = Store.find_by(name: stores[idx % 2]) #レンタル店舗
  return_store = Store.find_by(name: stores[idx % 3]) #返却店舗
  user = User.find_by(name: users[idx]) #予約ユーザ
  start_time = (Time.parse(rental_start[idx]).ceil_to(60.minutes)).floor# レンタル開始時間
  end_time = (Time.parse(rental_end[idx]).ceil_to(60.minutes)).floor# レンタル終了時間
  time_elapsed = (end_time - start_time)/ 3600 #経過時間
  total_price = time_elapsed * (car.price + price) #すべて期間外の料金
  Pricelist.all.each do |pricelist|
    if pricelist.season_start != nil
      if pricelist.season_start <= rental_start[idx] && rental_end[idx] <= pricelist.season_end # "全部期間中"
        total_price = time_elapsed * (car.price + pricelist.basic_price)
        # puts "#{pricelist.season_start} #{Time.parse(rental_start[idx])} #{Time.parse(rental_end[idx])} #{pricelist.season_end}"
        break
      elsif (rental_start[idx] < pricelist.season_start) && (pricelist.season_end < rental_end[idx]) # "期間をまたぐ"
        # puts "#{Time.parse(rental_start[idx])} #{pricelist.season_start} #{pricelist.season_end} #{Time.parse(rental_end[idx])}"
        term = (pricelist.season_end.ceil_to(60.minutes) - pricelist.season_start.ceil_to(60.minutes)) / 3600 #期間内経過時間
        term_price = term * (car.price + pricelist.basic_price) #期間内料金
        out_of_term = ((pricelist.season_start.ceil_to(60.minutes) - start_time) + (end_time - pricelist.season_end.ceil_to(60.minutes))) / 3600 #期間外経過時間
        out_of_term_price = out_of_term * (car.price + price) #期間外料金
        total_price = out_of_term_price + term_price #合計金額
        start_price = pricelist.season_start - start_time
        break
      elsif (pricelist.season_start < rental_start[idx]) && (rental_start[idx] < pricelist.season_end) && (pricelist.season_end < rental_end[idx])  # "前半のみ期間中""
        # puts "#{pricelist.season_start} #{Time.parse(rental_start[idx])} #{pricelist.season_end} #{Time.parse(rental_end[idx])}"
        term = (pricelist.season_end.ceil_to(60.minutes) - start_time) / 3600 #期間内経過時間
        term_price = term * (car.price + pricelist.basic_price) #期間内料金
        out_of_term = (end_time - pricelist.season_end.ceil_to(60.minutes)) / 3600 #期間外経過時間
        out_of_term_price = out_of_term * (car.price + price) #期間外料金
        total_price = out_of_term_price + term_price #合計金額
        break
      elsif (rental_start[idx] < pricelist.season_start) && (pricelist.season_start < rental_end[idx]) && (rental_end[idx] < pricelist.season_end)  # "後半のみ期間中"
        # puts "#{Time.parse(rental_start[idx])} #{pricelist.season_start}　#{rental_end[idx]} #{pricelist.season_end}"
        out_of_term = (pricelist.season_start.ceil_to(60.minutes) - start_time) / 3600 #期間外経過時間
        out_of_term_price = out_of_term * (car.price + price) #期間外料金
        term = (end_time - pricelist.season_start.ceil_to(60.minutes)) / 3600 #期間内経過時間
        term_price = term * (car.price + pricelist.basic_price) #期間内料金
        total_price = out_of_term_price + term_price #合計金額
        break
      end
    end
  end
  Booking.create(
    booking_code: "#{idx + 1}",
    rental_store: rental_store,
    return_store: return_store,
    car: car,
    user: user,
    rental_start: rental_start[idx],
    rental_end: rental_end[idx],
    total_price: total_price,
    status: status[idx % 3]
  )
end
