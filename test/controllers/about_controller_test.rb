require 'test_helper'

class AboutControllerTest < ActionDispatch::IntegrationTest
  test "should get me" do
    get about_url
    assert_response :success
  end

end
