class ChangePhotosBodyToText < ActiveRecord::Migration
  def self.up
    change_column :photos, :body, :text
  end

  def self.down
    change_column :photos, :body, :string
  end
end
