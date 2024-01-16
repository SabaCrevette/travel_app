class AddCityIdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :city_id, :bigint
    add_index :posts, :city_id
  end
end
