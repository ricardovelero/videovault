require "test_helper"

class Admin::VideosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_videos_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_videos_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_videos_create_url
    assert_response :success
  end

  test "should get show" do
    get admin_videos_show_url
    assert_response :success
  end
end
