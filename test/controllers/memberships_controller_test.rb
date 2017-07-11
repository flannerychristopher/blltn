require 'test_helper'

class MembershipsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @john = users(:john)
    @paul = users(:paul)
    @ringo = users(:ringo)
    @thebeatles = boards(:thebeatles)
    @johnmembership = memberships(:john)
    @ringomembership = memberships(:ringo)
  end

  test "can not change admin status through the web" do
    log_in_as(@paul)
    assert_no_difference 'Membership.where(admin: 1).count' do
      post memberships_path, params: {
                             membership: { user_id: @paul.id,
                                           board_id: @thebeatles.id,
                                           admin: 1 } }
    end
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Membership.count' do
      post memberships_path, params: { membership: { user_id: @paul.id,
                                                      board_id: @thebeatles.id } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Membership.count' do
      delete membership_path(@johnmembership), params: { id: @johnmembership }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong membership" do
    log_in_as(@paul)
    assert_no_difference 'Membership.count' do
      delete membership_path(@johnmembership), params: { id: @johnmembership }
    end
    assert_redirected_to root_url
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
