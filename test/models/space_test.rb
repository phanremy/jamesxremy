require "test_helper"

class SpaceTest < ActiveSupport::TestCase
  test 'it creates' do
    assert Space.create!(owner: users(:creator), description: 'My Space')
  end

  test 'does not update' do
    space1 = spaces(:default)
    space2 = spaces(:alternative)

    space2.update(description: space1.description, owner: space1.owner)

    assert_includes space2.errors.messages.keys, :description

    assert space2.update!(
      description: space1.description,
      owner: User.excluding(space1.owner).sample
    )
  end
end
