class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :location, null:false
      t.references :prefecture, foreign_key: true
      t.string :text, null: false
      t.integer :event_status, default: 0
      t.integer :public_status, default: 0

      t.timestamps
    end
  end
end
