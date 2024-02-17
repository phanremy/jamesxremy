require "test_helper"

module Spaces
  class UsersControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    test 'create - from existing user' do
      @user = users(:member)
      sign_in @user
      space = spaces(:default)
      space.update!(user_ids: [])
      assert_difference 'SpaceUser.count' do
        post space_users_path(space_id: spaces(:default).id),
             params: { space_user: { user_id: @user.id } }
        assert_response :success
      end
    end

    test 'create - from new user' do
      assert_difference 'SpaceUser.count' do
        assert_difference 'User.count' do
          post space_users_path(space_id: spaces(:default).id),
               params: { space_user: { user_attributes: { email: 'pocari@example.com',
                                                          password: 'password',
                                                          password_confirmation: 'password' } } }
          assert_response :success
        end
      end
    end
  end
end
