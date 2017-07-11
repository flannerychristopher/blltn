require 'test_helper'

class MembershipsCreateTest < ActionDispatch::IntegrationTest

  def setup
    @paul = users(:paul)
    @thebeatles = boards(:thebeatles)

    @ringo = users(:ringo)
    @ringomembership = memberships(:ringo)
  end

  test "user can join boards" do
    log_in_as(@paul)
    assert_not @paul.memberships.where(board_id: @thebeatles.id).any?
    # join
    get new_membership_path
    assert_difference '@paul.memberships.count', 1 do
      post memberships_path, params:     {
                             membership: { user_id: @paul.id,
                                          board_id: @thebeatles.id } }
    end
    assert @paul.memberships.where(board_id: @thebeatles.id).any?
  end

end
