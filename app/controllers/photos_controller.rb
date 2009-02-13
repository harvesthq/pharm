class PhotosController < ApplicationController
  before_filter :load_photo, :only => :show

  def home
    @photo = Photo.ordered.limited(1).first
    render :action => :show
  end
  
  def show; end

end
