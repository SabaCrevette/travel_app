class AddResetPasswordTokenIndexToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :access_count_to_reset_password_page, :integer, default: 0
    add_index :users, :reset_password_token, unique: true
  end
end