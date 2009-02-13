class PhotosController < ApplicationController
  before_filter :authenticate, :only => [:index, :new, :create, :edit, :update, :destroy]
  before_filter :load_photo, :only => [:show, :edit, :update, :destroy]

  def home
    @photo = Photo.ordered.limited(1).first
    render :action => :show
  end

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
  
  def update
    @photo.update_attributes(params[:photo])
    redirect_to photo_path(@photo)
  end
  
  def destroy
    @photo.destroy
    render :update do |page|
      page.remove dom_id(@photo)
    end
  end
  
private

  def load_photo
    @photo = Photo.find(params[:id])
  end
end
