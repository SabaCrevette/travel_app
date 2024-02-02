class AddCategoryAndPrefectureToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :category, foreign_key: true
    add_reference :users, :prefecture, foreign_key: true
  end
end
