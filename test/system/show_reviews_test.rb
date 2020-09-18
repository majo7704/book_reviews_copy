require "application_system_test_case"

class ShowReviewsTest < ApplicationSystemTestCase
  test "show displays title" do 
    visit(new_user_path)
    fill_in('email', with: 'monalisa3@epfl.ch')
    fill_in('password', with: 'password')
    
    click_on('Create User')

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
