require "application_system_test_case"

class ShowReviewsTest < ApplicationSystemTestCase
  test "show displays title" do 
user = User.new email: "me@aol.com"
    user.save!

    visit(new_user_path)
    fill_in('Email', with: user.email)
    click_on('Log in')

    review=Review.new title: "Enigma", 
                      author: "Robert Harris", 
                      body: "I finished the book regretful it had ended, and full of wonder at this extraordinary world, people and achievements it evoked",
                      user: User.new
    review.save!

    visit(review_path(review))
    assert page.has_content?('Enigma')
    assert page.has_content?('by Robert Harris')
    assert page.has_content?('review created on')
    click_link('Edit')

    assert_equal current_path, edit_review_path(review)
  end
end
