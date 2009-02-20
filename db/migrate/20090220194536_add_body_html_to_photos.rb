class AddBodyHtmlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :body_html, :text
    Photo.find(:all).each do |photo|
      photo.body_html = photo.body
      photo.save!
    end
  end

  def self.down
    remove_column :photos, :body_html
  end
end
