class AccountController < ApplicationController
  before_action :ensure_authenticated
  def reviews
    @reviews = Review.all
  end

  def ensure_authenticated
    unless(logged_in?)
      redirect_to login_path
    end
  end

end
