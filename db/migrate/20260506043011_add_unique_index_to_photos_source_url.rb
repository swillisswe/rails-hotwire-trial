class AddUniqueIndexToPhotosSourceUrl < ActiveRecord::Migration[8.1]
  def change
    add_index :photos, :source_url, unique: true
  end
end
