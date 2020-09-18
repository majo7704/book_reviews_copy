require "application_system_test_case"

class ReviewsTest < ApplicationSystemTestCase
  test "create new review" do
    user = User.new email: "me2@aol.com", password: "password"
    user.save!

    visit(new_session_path)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log in')
  
    visit(new_review_path)
    fill_in('review_title', with: '1984')
    fill_in('review_author', with: 'George Orwell')
    fill_in('review_body', with: "my absolute favorite book of all times! it's a fantastic read that will seem as SF as it does real.")
    fill_in('review_image_url', with: "https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9780/1410/9780141036144.jpg")
    click_on('commit')
    assert_equal current_path, reviews_path
    
   end

   test "index loads reviews" do
    review_1 = Review.new title: 'The Constant Rabbit', user: User.new
    review_1.save!

    review_2 = Review.new title: 'Peace Talks', user: User.new
    review_2.save!

    visit(reviews_path)

    assert page.has_content?('The Constant Rabbit')
    assert page.has_content?('Peace Talks')
   end 

   test "editing Review" do
    user = User.new email: "me@aol.com", password: "password"
    user.save!

    visit(new_session_path)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log in')
    
    review=Review.new title: "Hello you", user: user
    review.save!

    visit(edit_review_path(review))
    fill_in('review_title', with: 'Hello World')
    click_on('Update Review')
    
    click_link('edit')
    assert_equal page.find_field("review_title").value, 'Hello World'
    assert_equal current_path, edit_review_path(review)
   end 

   test "search" do
    review_1=Review.new title: "Girl, Woman, Other", 
                        author: "Bernardine Evaristo",
                        user: User.new
    review_1.save!
    review_2=Review.new title: "Sapiens", 
                        author: "Yuval Noah Harari",
                        user: User.new
    review_2.save!

    visit(root_path)
    fill_in('q', with:'girl')
    click_on('Search', match: :first)

    assert current_path.include?(reviews_path)
    assert page.has_content?('Girl, Woman, Other')
    refute page.has_content?('Sapiens')
   end 

   test "search by title and author" do
    review_1=Review.new title: "Girl, Woman, Noah", 
                        author: "Bernardine Evaristo",
                        user: User.new
    review_1.save!
    review_2=Review.new title: "Sapiens", 
                        author: "Yuval Noah Harari",
                        user: User.new
    review_2.save!

    visit(root_path)
    fill_in('q', with:'noah')
    click_on('Search', match: :first)

    assert page.has_content?('Girl, Woman, Noah')
    assert page.has_content?('Sapiens')
    refute page.has_content?('Exciting world')
   end 

   test "no search results" do 
    visit(reviews_path)
    assert page.has_content?('Nothing to display!')
   end

   test "empty string search" do
    visit(root_path)
    fill_in('q', with:'')
    click_on('Search', match: :first)
    
    assert page.has_content?('Please enter a title or an author!')
  end

  test "home_page highlights" do
    7.times do |i|
      review = Review.new title: "Exciting world #{i+1}", 
                          user: User.new
      review.save!
    end
    visit(root_path)
    assert page.has_content?('Exciting world 7')
    assert page.has_content?('Exciting world 6')
    assert page.has_content?('Exciting world 5')
    assert page.has_content?('Exciting world 4')
    assert page.has_content?('Exciting world 3')
    assert page.has_content?('Exciting world 2')
    refute page.has_content?('Exciting world 1')
  end 

  test "new review with no title" do
    user = User.new email: "me@gmail.com", password: "password"
    user.save!

    visit(new_session_path)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log in')
  

    visit(new_review_path)
    fill_in('review_author', with: 'George Orwell')
    click_on('Create Review')

    assert page.has_content?("Title can't be blank")
  end 

  test "existing review with updating author too long" do
    user = User.new email: "me4@aol.com", password: "password"
    user.save!

    visit(new_session_path)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log in')
    review = Review.new author:'George Orwell', 
                        title:'1894',
                        user: User.new
                        
    review.save!
    visit(edit_review_path(review))
    fill_in('review_author', with: 'George OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge OrwellGeorge Orwell')
    click_on('Update Review')

    assert page.has_content?("Author is too long (maximum is 100 characters)")
  end


end
