class AdminUsersController < AdminController
  def edit
    @user = User.blog_user
  end
  
  def create
    User.create(params[:user])
    redirect_to admin_path
  end
  
  def update
    @user = User.blog_user
    @user.update_attributes(params[:user])
    redirect_to admin_path
  end
end
