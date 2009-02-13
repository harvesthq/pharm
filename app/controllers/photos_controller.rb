class PhotosController < ApplicationController
  before_filter :load_photo, :only => :show
  
  def show; end

end
