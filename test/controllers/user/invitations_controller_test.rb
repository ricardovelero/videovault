require "test_helper"

class User::InvitationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_invitations_index_url
    assert_response :success
  end

  test "should get new" do
    get user_invitations_new_url
    assert_response :success
  end

  test "should get create" do
    get user_invitations_create_url
    assert_response :success
  end
end
