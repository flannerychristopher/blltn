require 'test_helper'

class MembershipsCreateTest < ActionDispatch::IntegrationTest

  def setup
    @paul = users(:paul)
    @thebeatles = boards(:thebeatles)
  end

  test "user can join and unjoin boards" do
    assert_not @paul.memberships.where(board_id: @thebeatles.id).any?
    # join
    get new_membership_path
    assert_difference '@paul.memberships.count', 1 do
      post memberships_path, params:     {
                             membership: { user_id: @paul.id,
                                          board_id: @thebeatles.id } }
    end
    assert @paul.memberships.where(board_id: @thebeatles.id).any?
    # unjoin
    @paulmembership = Membership.find_by(user_id: @paul.id, board_id: @thebeatles.id)
    assert_difference '@paul.memberships.count', 1 do
      delete membership_path, params: { membership: { id: 1 } }
                              # membership: { user_id: @paul.id,
                              #               board_id: @thebeatles.id } }
    end

  end

end
