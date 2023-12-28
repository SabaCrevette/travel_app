class AddNotNullConstraintToPrefectureIdInPosts < ActiveRecord::Migration[7.1]
  def change
    change_column :posts, :prefecture_id, :bigint, null: false
  end
end
