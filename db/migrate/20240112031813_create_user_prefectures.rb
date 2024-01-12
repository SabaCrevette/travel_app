class CreateUserPrefectures < ActiveRecord::Migration[7.1]
  def change
    create_table :user_prefectures do |t|
      t.bigint :user_id
      t.bigint :prefecture_id
      t.integer :post_count, default: 0

      t.timestamps
    end

    add_foreign_key :user_prefectures, :users
    add_foreign_key :user_prefectures, :prefectures
  end
end
