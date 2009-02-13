class PhotosController < ApplicationController
  before_filter :load_photo, :only => [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.ordered
  end
  
  def show; end
  
  def new; end
    
  def create
    photo = Photo.create(params[:photo])
    redirect_to photo_path(photo)
  end
  
  def edit; end
  
private

  def load_photo
    @photo = Photo.find(params[:id])
  end
end
