class PhotosController < ApplicationController
  before_filter :load_user
  before_filter :load_photo, :only => :show

  def home
    @photo = Photo.ordered.limited(1).first
    show
  end
  
  def show
    if stale?(:etag => @photo, :last_modified => [@photo.updated_at.utc, @user.updated_at.utc].sort.last)
      render :action => :show
    end
  end

end
