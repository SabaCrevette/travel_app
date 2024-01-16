class RemoveCityIdFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :city_id, :bigint
  end
end
