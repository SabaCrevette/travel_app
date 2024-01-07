class AddImageToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :images, :json
  end
end
