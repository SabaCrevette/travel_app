class CreateReleaseNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :release_notes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
