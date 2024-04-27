require "test_helper"

class SpacesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:creator)
  end

  test 'index' do
    get spaces_path
    assert_response :success

    sign_in users(:visitor)
    get spaces_path
    assert_response :redirect
  end

  test 'show' do
    get space_path(id: spaces(:default).id)
    assert_response :success
  end

  test 'edit' do
    get edit_space_path(id: spaces(:default).id)
    assert_response :success
  end

  test 'create' do
    assert_difference 'Space.count' do
      post spaces_path, params: { commit: true, space: { description: 'example' } }
      assert_response :redirect
      assert_redirected_to Space.last
    end
  end

  test 'update' do
    space = spaces(:default)
    assert_changes -> { space.reload.description } do
      put space_path(id: space.id), params: { commit: true, space: { description: 'example' } }
      assert_response :redirect
      assert_redirected_to space_path(id: space.id)
    end
  end

  test 'destroy' do
    assert_difference 'Space.count', -1 do
      delete space_path(id: spaces(:default).id)
      assert_response :redirect
      assert_redirected_to spaces_path
    end
  end
end
