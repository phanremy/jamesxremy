require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
  end

  test 'index' do
    get users_path
    assert_response :success
  end

  test 'edit' do
    get edit_user_path(id: users(:creator).id)
    assert_response :success
  end

  test 'update' do
    user = users(:creator)
    assert_changes -> { user.reload.admin } do
      put user_path(id: user.id), params: { user: { admin: true } }
      assert_response :redirect
      assert_redirected_to users_path
    end
  end
end
