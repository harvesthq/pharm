class PhotosController < ApplicationController
  
  def show
    @photo = Photo.find(params[:id])
  end
  
  def new; end
    
  def create
    photo = Photo.create(params[:photo])
    redirect_to photo_path(photo)
  end
end
