class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts.paginate(:page => params[:page])
  end

  def new
    @user = User.new
  	@title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
  end

  def update 
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    user_to_destroy = User.find(params[:id])
    # do not allow admin user to delete self
    if current_user?(user_to_destroy)
      flash[:error] = "You cannot delete yourself"
    else
      User.find(params[:id]).destroy
	  flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    render_follow_action(@user.following)
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    render_follow_action(@user.followers)
  end
  
  private

    def render_follow_action(userArray)
      @users = userArray.paginate(:page => params[:page])
      render 'show_follow'
    end

    def correct_user
      @user = User.find(params[:id])
	  redirect_to(root_path) unless current_user?(@user)      
    end

    def admin_user
        if (current_user.nil?)
          redirect_to(signin_path)
        else
          redirect_to(root_path) unless current_user.admin?
		end
    end
end
