module ApplicationHelper
  def can_edit?(bookmark)
    current_user == bookmark.user
  end
end
