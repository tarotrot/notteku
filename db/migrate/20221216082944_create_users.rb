class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false                           # ユーザー名
      t.boolean :admin, null: false, default: false         # 管理者フラグ
      t.integer :sex, null: false, default: 1               # 性別 (0:男, 1:女)
      t.date :birthday                                      # 生年月日
      t.string :phone, null: false                          # 電話番号
      t.string :email, null: false                          # メールアドレス
      t.string :password_digest

      t.timestamps
    end
  end
end
