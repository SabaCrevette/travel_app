class CreateAuthentications < ActiveRecord::Migration[7.1]
  def change
    create_table :authentications do |t|
      t.integer :user_id, :null => false
      t.string :provider, :uid, :null => false

      t.timestamps
    end

    add_index :authentications, [:provider, :uid]
    add_index :authentications, :user_id # user_idにindexを貼る場合は追加
  end
end
