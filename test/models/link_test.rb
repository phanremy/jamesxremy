# frozen_string_literal: true

require "test_helper"

class LinkTest < ActiveSupport::TestCase

  setup { @link = links(:default) }

  test 'creates' do
    old_link = @link

    new_link = Link.create!(space: old_link.space, owner: old_link.owner)

    assert_nil Link.find_by(id: old_link.id)
    assert new_link.sku
    assert new_link.end_date
  end

  test 'does not update' do
    link1 = @link
    link2 = links(:alternative)

    link2.update(sku: link1.sku)

    assert_includes link2.errors.messages.keys, :sku

    link2.update(space: link1.space, owner: link1.owner)

    assert_includes link2.errors.messages.keys, :space
  end

  test 'genuine link' do
    assert @link.genuine?
  end

  test 'genuine link owner is not confirmed' do
    @link.owner.update!(confirmed: false)

    assert_not @link.genuine?
  end

  test 'genuine link owner is an admin' do
    @link.update!(owner: users(:admin))

    assert @link.genuine?
  end

  test 'genuine link is expired' do
    @link.update!(end_date: DateTime.now - 1.second)

    assert_not @link.genuine?
  end
end
