require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get about" do
    get home_about_url
    assert_response :success
  end

  test "should get search" do
    get home_search_url
    assert_response :success
  end

  test "should get feedback" do
    get home_feedback_url
    assert_response :success
  end

end
