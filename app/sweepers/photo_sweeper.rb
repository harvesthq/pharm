class PhotoSweeper < ActionController::Caching::Sweeper
  observe Photo

  def after_save(photo)
    expire_cache_for(photo)
  end
  
  def after_destroy(photo)
    expire_page('/index.html')
    expire_cache_for(photo)
  end
  
private

  def expire_cache_for(photo)
    expire_page('/index.html')  # Really only need this on create, destroy, and edit of most recent photo
    expire_page(:controller => 'photos', :action => 'show', :id => photo.id)
  end
  
end