names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
0.upto(9) do |idx|
  User.create(
    name: names[idx],
    admin: (idx == 0),
    sex: [0, 0, 1][idx % 3],
    birthday: "1981-12-01",
    phone: "012-3456-789#{idx}",
    email: "#{names[idx]}@example.com",
    password: "senshudaigaku",
    password_confirmation: "senshudaigaku"
  )
end
