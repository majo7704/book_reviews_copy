class AccountController < ApplicationController
  before_action :ensure_authenticated

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to account_path
  end  

  def reviews
    user = User.find(session[:user_id])
    @reviews = user.reviews
  end

  def bookmarks
    @bookmarks = current_user.bookmarks
  end


  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar_url)
  end

end
