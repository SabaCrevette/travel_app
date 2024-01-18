class CreateAreaMappings < ActiveRecord::Migration[7.1]
  def change
    create_table :area_mappings do |t|
      t.references :prefecture, null: false, foreign_key: true, type: :bigint
      t.references :area, null: false, foreign_key: true, type: :bigint
      t.string :city

      t.timestamps
    end
  end
end
