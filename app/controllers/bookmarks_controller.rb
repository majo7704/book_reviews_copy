class BookmarksController < ApplicationController

  def create
    user=User.find(params[:user_id])
    review = Review.find(params[:review_id])
    user.bookmarks << review
    redirect_to review_path(review)
  end 
  
  def index
    if(session[:user_id].present?)
      user = User.find(session[:user_id])
      @bookmarks = user.bookmarks.all
    else
      @bookmarks=nil
    end
  end  

  def destroy
    @user = User.find(session[:user_id])
    @review = Review.find(params[:id])
    @user.bookmarks.destroy @review
    

    redirect_to account_reviews_path
  end

  
end
