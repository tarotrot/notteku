car_codes = ["hondaNBox1", "toyotaAqua1", "FerrariRoma1", "SubaruLevorg1", "daihatsuHijetTruck1", "toyotaYaris1"]
car_types = ["乗用車", "軽自動車", "高級車", "ミニバン・ワゴン車", "トラック"]
names = ["ホンダ N-BOX", "トヨタ アクア", "フェラーリ ローマ", "スバル レヴォーグ", "ダイハツ　ハイゼットトラック", "トヨタ ヤリス"]
status = ["予約可能","準備中", "貸出中"]
price = [800, 600, 3000, 500, 500]
stores = ["生田店", "神田店"]
0.upto(5) do |idx|
  store = Store.find_by(name: stores[idx % 2])
  Car.create(
    car_code: car_codes[idx],
    car_type: car_types[idx % 5],
    store: store,
    name: names[idx],
    status: status[idx % 3],
    price: price[idx % 5]
  )
end
