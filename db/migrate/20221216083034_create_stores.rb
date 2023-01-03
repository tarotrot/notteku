class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :store_code, null: false                   # 店舗コード
      t.string :name, null: false                         # 店舗名
      t.datetime :start_time, null: false                 # 営業開始時刻
      t.datetime :end_time, null: false                   # 営業終了時刻
      t.string :address, null: false                       # 住所
      t.string :phone_number, null: false                 # 電話番号

      t.timestamps
    end
  end
end
