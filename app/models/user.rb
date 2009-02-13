class User < ActiveRecord::Base
  attr_accessible :name, :title, :about, :photo_width, :footnotes
  
  class << self
    def blog_user
      find(:first) || new
    end
  end
end
