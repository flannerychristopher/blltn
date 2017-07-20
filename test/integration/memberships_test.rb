require 'test_helper'

class MembershipsTest < ActionDispatch::IntegrationTest

  def setup
    @paul = users(:paul)
    @ringo = users(:ringo)
    @ringomembership = memberships(:ringo)
    @board = boards(:thebeatles)
  end

  test "should join membership in standard way" do
    log_in_as(@paul)
    assert_difference '@paul.memberships.count', 1 do
      post memberships_path, params: {
                             membership: { user_id: @paul.id,
                                           board_id: @board.id } }
    end
  end

  test "should join membership with AJAX" do
    log_in_as(@paul)
    # assert_difference "@paul.memberships.count", 1 do
    #   post memberships_path, xhr: true, params: {
    #                                     membership: { user_id: @paul.id,
    #                                                   board_id: @board.id } }                                                   } }
    # end
  end

  test "should unjoin in standard way" do
    log_in_as(@ringo)
    assert_difference 'Membership.count', -1 do
      delete membership_path(@ringomembership), params: {
                              membership: { board_id: @board.id } }
    end
  end

  test "should unjoin with AJAX" do
    log_in_as(@ringo)
    assert_difference 'Membership.count', -1 do
      delete membership_path(@ringomembership), xhr: true,
                              params: { membership: { board_id: @board.id } }
    end
  end


end
