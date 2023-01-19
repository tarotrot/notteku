stores = ["生田店", "神田店", "向ヶ丘遊園店"]
store_codes = ["ikuta1", "kanda1", "mukougaokayuen1"]
postal_codes = ["2148580", "1018425", "1234567"]
addresses = ["神奈川県川崎市多摩区東三田2丁目1-1", "東京都千代田区神田神保町3-8", "川崎市多摩区登戸2098"]
phone_numbers = ["000-0000-0000", "111-1111-1111", "222-2222-2222"]
0.upto(2) do |idx|
  Store.create(
    store_code: store_codes[idx],
    name: stores[idx],
    start_time: "09:00",
    end_time: "20:00",
    address: addresses[idx],
    postal_code: postal_codes[idx],
    phone_number: phone_numbers[idx]
  )
end
