require "application_system_test_case"

class ReviewCommentsTest < ApplicationSystemTestCase
  test "adding a Comment to the Review" do
    user=User.new email:'test@epfl.ch', password:'password'
    user.save!

    review=Review.new title:"Make it happen", user: user
    review.save!

    visit(new_session_path)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log in')

    visit(review_path(review))
    fill_in('comment[body]', with: "it was such a uplifting story")
    click_on('Submit comment', match: :first)
    
    assert current_path.include?(review_path(review))
    assert page.has_content?('it was such a uplifting story')
  end

  test 'comments cannot be added when not logged in' do
    review=Review.new title: 'Dancing with wolves', user: User.new
    review.save!
    visit(review_path(review))
    refute page.has_content?('Add a comment')
  end
end
