class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :title, :body, :asset_file_name, :asset_content_type
      t.integer :asset_file_size
      t.datetime :asset_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
