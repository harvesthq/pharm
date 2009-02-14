module AdminHelper
  def options_for_photo_width_select
    [
      [Photo::PHOTO_SIZES[:small], 'small'], 
      [Photo::PHOTO_SIZES[:medium], 'medium'], 
      [Photo::PHOTO_SIZES[:large], 'large']
    ]
  end
end