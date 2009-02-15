class AdminUsersController < AdminController
  after_filter :expire_pages, :only => [:create, :update]

  def edit
    @user = User.blog_user
  end
  
  def create
    User.create(params[:user])

    flash[:notice] = "Settings updated"
    redirect_to admin_path
  end
  
  def update
    @user = User.blog_user
    @user.update_attributes(params[:user])

    flash[:notice] = "Settings updated"
    redirect_to admin_path
  end
  
private

  def expire_pages
    expire_page('/index.html')
    Photo.find(:all, :select => 'id').map(&:id).each do |_id|
      expire_page(:controller => 'photos', :action => 'show', :id => _id)
    end
  end
end
