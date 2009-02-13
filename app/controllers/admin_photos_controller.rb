class AdminPhotosController < ApplicationController
  before_filter :authenticate
  before_filter :load_photo, :only => [:edit, :update, :destroy]

  layout 'admin'
  
  def index
    @photos = Photo.ordered
  end
    
  def new; end
    
  def create
    photo = Photo.create(params[:photo])
    
    redirect_to admin_photos_path
  end
  
  def edit; end
  
  def update
    @photo.update_attributes(params[:photo])
    redirect_to admin_photos_path
  end
  
  def destroy
    @photo.destroy
    render :update do |page|
      page.remove dom_id(@photo)
    end
  end
  
end
