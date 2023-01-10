class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :booking_code, null: false                                                     # 予約コード
      # t.references :rental_store, null: false, foreign_key: {to_table: :stores}               # レンタル店舗
      # t.references :return_store, null: false, foreign_key: {to_table: :stores}               # 返却店舗
      # t.references :car, null: false                                                          # 車
      t.references :rental_store, foreign_key: {to_table: :stores}               # レンタル店舗
      t.references :return_store, foreign_key: {to_table: :stores}               # 返却店舗
      t.references :car                                                         # 車
      t.references :user, null: false                                                         # ユーザ
      t.datetime :rental_start, null: false                                                   # レンタル開始時刻
      t.datetime :rental_end, null: false                                                     # レンタル終了時刻
      t.integer :total_price, null: false                                                     # 合計金額
      t.string :status, null: false                                                           # 予約状態
      t.timestamps
    end
  end
end
