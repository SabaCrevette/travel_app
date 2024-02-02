class CreateCategoryTags < ActiveRecord::Migration[7.1]
  def change
    create_table :category_tags do |t|
      t.references :category, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    # 同じカテゴリーIDとタグIDの組み合わせが重複しないようにインデックスを追加
    add_index :category_tags, [:category_id, :tag_id], unique: true
  end
end
