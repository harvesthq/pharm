class AddBodyHtmlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :body_html, :text
  end

  def self.down
    remove_column :photos, :body_html
  end
end
