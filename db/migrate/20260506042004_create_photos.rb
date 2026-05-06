class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.string :photographer, null: false
      t.string :image_url, null: false
      t.string :source_url, null: false
      t.string :alt

      t.timestamps
    end
  end
end
