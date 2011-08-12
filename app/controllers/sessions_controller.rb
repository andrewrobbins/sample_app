class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password]);
    if user.nil?
      # create error message and re-render sign-in page
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render :new
    else
      # sign in the user and redirect to the user's show page
      sign_in user
      # if client was redirected to signin page, friendly forward back, otherwise
      #   default to the profile page
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
