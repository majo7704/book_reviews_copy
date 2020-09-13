require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test "changing the title" do
    review=Review.new title: "Think Like a Monk", user: User.new
    review.save!

    updated_at = review.updated_at

    review.title="Shine"
    assert review.save
    refute_equal review.updated_at, updated_at
  end

  test "setting the title to empty string" do
    review=Review.new title: "Think Like a Monk", user: User.new
    review.save!

    updated_at = review.updated_at

    review.title="Think like a monk"
    assert review.save
    refute_equal review.updated_at, updated_at
  end

  test "the first empty review created in the list" do
    first_review = Review.new title: 'Shine start', user: User.new
    first_review.save!
    second_review = Review.new title: "Empty title", user: User.new
    second_review.save!
    assert_equal(first_review, Review.all.first)
  end  

  test "updated_at is changed after updating title" do
    review=Review.new title: "The Silent Wife", user: User.new
    review.save!

    first_updated_at=review.updated_at
    review.title="How to Disappear"
    review.save!
    refute_equal(review.updated_at, first_updated_at)
  end  

  test "the first complete Review created is first in the list" do
    first_review=Review.new title: "The Room Where ItHappened",   
                            author:"John Bolton", 
                            body:"I can't believe I'm saying this: it's worse than I even imagined.",
                            image_url:"https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9781/9821/9781982148034.jpg",
                            user: User.new
    first_review.save!
    second_review=Review.new title: "The Happy Pear: Vegan Cooking for Everyone : Over 200 Delicious Recipes That Anyone Can Make", 
                            author: " David Flynn",
                            body: "Vegan Cooking for Everyone is the vegan cooking bible, distilling their twenty years of plant-based cooking experience into ten chapters.",
                            image_url: "https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9781/8448/9781844884872.jpg",
                            user: User.new
    second_review.save!
    assert_equal(first_review, Review.all.first)
  end  

  test "updated_at is changed after updating author" do
    review=Review.new title: 'Let it be', 
                      user: User.new, 
                      author:"Karin Slaughter"
    review.save!

    first_updated_at=review.updated_at
    review.author="Gillian McAllister"
    review.title= 'Let it be'
    review.save!
    refute_equal(review.updated_at, first_updated_at)
  end  

  test "updated_at is changed after updating image url" do
    review=Review.new title: 'Let it be', 
                      image_url: "https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9780/0083/9780008303440.jpg", 
                      user: User.new
    review.save!

    first_updated_at=review.updated_at
    review.title= 'Let it be'
    review.image_url="https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9781/4059/9781405942423.jpg"
    review.save!
    refute_equal(review.updated_at, first_updated_at)
  end  

  test 'search with one matching result' do
    review=Review.new title: "The Exit break", user: User.new
    review.save!

    assert_equal Review.search('exit').length,1
  end  

  test 'search with no matching result' do
    review=Review.new title: "The Exit break", user: User.new
    review.save!

    assert_empty Review.search('blue')
  end  

  test 'search with 2 matching results' do
    review=Review.new title: "The Exit break", user: User.new
    review.save!

    review_0=Review.new title: "The break room", user: User.new
    review_0.save!

    assert_equal Review.search('break').length,2
  end  

  test 'most_recent with no reviews' do
    assert_empty Review.most_recent
  end  

  test 'most_recent with 2 reviews' do 
    review=Review.new title: "The Exit break", user: User.new
    review.save!

    review_0=Review.new title: "The break room", user: User.new
    review_0.save!

    assert_equal Review.most_recent.length,2
    assert_equal Review.most_recent.first, review_0
  end

  test 'most_recent with six reviews' do
    6.times do |i|
      review=Review.new title: "Great World #{i+1}", user: User.new
      review.save!
    end
    assert_equal Review.most_recent.length,6
    assert_equal Review.most_recent.first.title, "Great World 6"
  end

  test 'search with only author match' do
    review=Review.new title: "The Exit break", 
                      author: "Mark White", 
                      user: User.new
    review.save!

    assert_equal 1, Review.search('white').length
  end

  test 'search with author and title' do
    review=Review.new title: "The Exit break", 
                      author: "Mark White", 
                      user: User.new
    review.save!

    review_0=Review.new title: "The white room", 
                        author: "Ronald Boxton",
                        user: User.new
    review_0.save!

    assert_equal Review.search('white').length,2
  end

  test "maximum characters of author" do
    review=Review.new author: 'Thisisanameofaverylongauthorfirstname thisisalastnameofaverylongauthorlastname', 
                      user: User.new
    refute review.valid?
  end

  test "presence of title" do
    review=Review.new
    refute review.valid?
  end 
end
