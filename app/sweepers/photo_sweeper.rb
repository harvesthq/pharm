class PhotoSweeper < ActionController::Caching::Sweeper
  observe Photo

  def before_create(photo)
    Photo.ordered.limited(2).selection(:id).each do |photo|
      expire_page(:controller => 'photos', :action => 'show', :id => photo)
    end
  end

  def after_create(photo)
    expire_page('/index.html')
    expire_page(:controller => 'photos', :action => 'show', :id => Photo.oldest_photo_id)
  end

  def after_save(photo)
    expire_cache_for(photo)
  end
  
  def after_destroy(photo)
    expire_page('/index.html')
    expire_cache_for(photo)
  end
  
private

  def expire_cache_for(photo)
    expire_page(:controller => 'photos', :action => 'show', :id => photo.id)
  end
  
end