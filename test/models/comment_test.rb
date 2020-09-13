require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  test 'changing the associated Review for a Comment' do
    
    review=Review.new title: 'The Expectations', user: User.new
    review.save

    comment=Comment.new body:"Greate book", review: review, user: User.new
    comment.save

    review_2=Review.new title: 'Mastery', user: User.new
    review_2.save

    comment.review = review_2
    comment.save

    assert_equal review_2, Comment.first.review
  end

  test "cascading save" do
    review=Review.new title:"You snooze you loose", user: User.new
    review.save

    comment=Comment.new body:"Great book!", user: User.new
    review.comments << comment
    review.save

    assert_equal comment, Comment.first

  end

  test "Comments are ordered correctly" do
    review=Review.new title: "Roman times", user: User.new
    review.save

    comment=Comment.new body: "This was a great read!!!", user: User.new
    comment_2=Comment.new body: "Yes I agree!!!", user: User.new

    review.comments << comment
    review.comments << comment_2

    review.save

    assert_equal review.comments.first, comment
    assert_equal review.comments.length,2
  end
end
