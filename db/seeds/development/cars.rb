car_codes = ["hondaNBox", "toyotaAqua", "FerrariRoma", "SubaruLevorg", "daihatsuHijetTruck", "toyotaYaris"]
car_types = ["乗用車", "軽自動車", "高級車", "ミニバン・ワゴン車", "トラック", "乗用車"]
names = ["ホンダ N-BOX", "トヨタ アクア", "フェラーリ ローマ", "スバル レヴォーグ", "ダイハツ　ハイゼットトラック", "トヨタ ヤリス"]
status = ["準備中", "予約可能", "予約可能"]
price = [800, 600, 3000, 500, 500, 900]
stores = ["生田店", "神田店", "生田店"]
0.upto(5) do |idx|
  store = Store.find_by(name: stores[idx % 3])
  Car.create(
    car_code: "#{car_codes[idx]}#{(idx+6)/6}",
    car_type: car_types[idx % 5],
    store: store,
    name: names[idx],
    status: status[idx % 3],
    price: price[idx % 5]
  )
end
6.upto(55) do |idx|
  store = Store.find_by(name: stores[idx % 3])
  Car.create(
    car_code: "#{car_codes[idx]}#{(idx+6)/6}",
    car_type: car_types[idx % 6],
    store: store,
    name: "#{names[idx%6]}#{(idx+6)/6}",
    status: "予約可能",
    price: price[idx % 6]
  )
end
