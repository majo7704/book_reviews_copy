class SessionsController < ApplicationController
  def new 
  end

  def create
    
    user = User.find_by(email: params[:email].downcase)

    if(user.present? && user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to account_reviews_path
    else
      flash[:alert] = 'Email or password were invalid. Plaese try again'
      render 'new'
    end
  end  
end
