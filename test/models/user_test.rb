require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'email is lowercase before validation' do
    user = User.new email:'mE@EpfL.ch', password:'password'
    user.save!
    assert_equal 'me@epfl.ch', user.email
  end

end
