require "test_helper"

class SpaceUserTest < ActiveSupport::TestCase
  test 'it updates' do
    space = spaces(:default)

    assert space.users.include?(users(:member))
    assert_not space.users.include?(users(:visitor))

    space.update!(user_ids: [users(:visitor).id])

    assert_not space.users.include?(users(:member))
    assert space.users.include?(users(:visitor))
  end
end
