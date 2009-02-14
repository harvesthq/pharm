class DefaultPhotoWidthOnUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :photo_width, :string, :default => 'medium', :null => false
  end

  def self.down
    change_column :users, :photo_width, :string, :null => false
  end
end
