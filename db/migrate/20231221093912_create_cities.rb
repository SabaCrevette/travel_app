class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.references :prefecture, foreign_key: true
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :area, foreign_key: true

      t.timestamps
    end
  end
end
