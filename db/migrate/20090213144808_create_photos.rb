class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column :title, :string, :null => false
      t.column :asset_file_name, :string, :null => false
      t.column :asset_content_type, :string, :null => false
      t.column :asset_file_size, :integer, :null => false
      t.column :asset_updated_at, :datetime, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
