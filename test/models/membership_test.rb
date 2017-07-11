require 'test_helper'

class MembershipTest < ActiveSupport::TestCase

  def setup
    @membership = memberships(:john)
  end

  test "membership is valid" do
    assert @membership.valid?
  end

  test "membership requires user id" do
    @membership = Membership.new(user_id: nil, board_id: 1)
    assert_not @membership.valid?
  end

  test "membership requires board id" do
    @membership = Membership.new(user_id: 1, board_id: nil)
    assert_not @membership.valid?
  end


end
