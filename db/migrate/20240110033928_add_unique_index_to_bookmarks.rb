class AddUniqueIndexToBookmarks < ActiveRecord::Migration[7.1]
  def change
    add_index :bookmarks, [:user_id, :post_id], unique: true
  end
end
