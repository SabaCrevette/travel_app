class AddAreaIdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :area_id, :bigint
    add_foreign_key :posts, :areas, column: :area_id
    add_index :posts, :area_id
  end
end
