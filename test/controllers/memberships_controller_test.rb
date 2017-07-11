require 'test_helper'

class MembershipsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @john = users(:john)
    @paul = users(:paul)
    @thebeatles = boards(:thebeatles)
    @johnmembership = memberships(:john)
  end

  test "can not change admin status through the web" do

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

end
