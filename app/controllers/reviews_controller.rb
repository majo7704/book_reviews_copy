class ReviewsController < ApplicationController
  
  def index
    @search_term = params[:q]
    logger.info("Search completed for #{@search_term}.")
    @reviews = Review.search(@search_term)
    @reviews_count = @reviews.count
  end

def show
    @review = Review.find(params[:id])
    @comment = Comment.new
    @display_add_comment = session[:user_id].present?
   
    if(session[:user_id].present?)
      @user = User.find(session[:user_id])
      @disable_add_bookmark = @user.bookmarks.exists?(@review.id)
    else
      @user=nil
    end
    
  end  


  def new
    @review=Review.new
  end

  def create
    user = User.find(session[:user_id])
    @review = Review.new(review_resource_params)
    @review.user = user
    if(@review.save)
      redirect_to reviews_path
    else
      render 'new'
    end  
  end

  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    user = User.find(session[:user_id])
    @review = Review.find(params[:id])
    @review.user = user
    if(@review.update(review_resource_params))
      redirect_to account_reviews_path
    else
      render 'edit'
    end 
  end 

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to account_reviews_path
  end

  private


  def review_resource_params
    params.require(:review).permit(:title, :author, :body, :image_url)
  end  
  
end
