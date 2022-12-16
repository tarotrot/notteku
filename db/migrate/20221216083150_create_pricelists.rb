class CreatePricelists < ActiveRecord::Migration[5.2]
  def change
    create_table :pricelists do |t|
      t.integer :basic_price, null: false                   # 基本金額
      t.datetime :season_start, null: false                 # 期間開始
      t.datetime :season_end, null: false                   # 期間終了
      t.string :name, null: false                           # 名前
      t.timestamps
    end
  end
end
