require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @link = links(:default)
    @user = users(:creator)
    sign_in @user
  end

  test 'create' do
    space = spaces(:default)
    assert_no_difference 'Link.count' do
      post links_path, params: { link: { space_id: space.id, owner_id: space.owner.id } }
    end

    @user.available_link(space).destroy

    assert_difference 'Link.count' do
      post links_path, params: { link: { space_id: space.id, owner_id: space.owner.id } }
    end
  end

  test 'destroy' do
    assert_difference 'Link.count', -1 do
      delete link_path(sku: @link.sku)
    end
  end

  test 'show - redirect' do
    sign_in users(:member)
    get link_path(sku: @link.sku)

    assert_response :redirect
    assert_redirected_to @link.space
  end

  test 'show - render' do
    sign_in users(:visitor)
    get link_path(sku: @link.sku)

    assert_response :success
  end

  test 'show - failure' do
    @link.update!(expires_at: DateTime.now - 1.second)
    sign_in users(:visitor)
    get link_path(sku: @link.sku)

    assert_response :redirect
    assert_redirected_to root_path
  end
end
