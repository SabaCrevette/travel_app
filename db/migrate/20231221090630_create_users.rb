class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :crypted_password
      t.integer :role, default: 0
      t.integer :public_status, default: 0
      t.string :salt

      t.timestamps
    end
  end
end
