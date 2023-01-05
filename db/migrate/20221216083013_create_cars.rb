class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :car_code, null: false                      # 車コード
      t.string :car_type, null: false                      # 車種
      t.references :store                                  # レンタル店舗
      t.string :name, null: false                          # 車名
      t.string :status, null: false                        # 状態
      t.integer :price, null: false                        # 金額
      t.timestamps
    end
  end
end
