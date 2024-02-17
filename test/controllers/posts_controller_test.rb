# frozen_string_literal: true

require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'it renders a list of posts' do
    get posts_url

    assert_response :success
  end
end
