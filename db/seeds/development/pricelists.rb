names = %w(基本プラン 春休み 夏休み)
price = [1000, 800, 700]
start_date = ["2023-03-01-00:00:00", "2023-08-01-00:00:00"]
end_date = ["2023-03-31-00:00:00", "2023-08-31-00:00:00"]

0.upto(2) do |idx|
  if idx == 0
    Pricelist.create(
      name: names[idx],
      basic_price: price[idx]
    )
  else
    Pricelist.create(
      name: names[idx],
      season_start: start_date[idx - 1],
      season_end: end_date[idx - 1],
      basic_price: price[idx]
    )
  end
end
