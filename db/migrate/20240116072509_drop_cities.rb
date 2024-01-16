class DropCities < ActiveRecord::Migration[7.1]
  def up
    drop_table :cities
  end

  def down
    create_table :cities do |t|
      t.bigint :prefecture_id
      t.string :address
      t.float :latitude
      t.float :longitude
      t.bigint :area_id
      t.timestamps
    end
    add_index :cities, :prefecture_id
    add_index :cities, :area_id
  end
end
