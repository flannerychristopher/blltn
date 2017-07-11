require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @john = users(:john)
    @ringo = users(:ringo)
    @thebeatles = boards(:thebeatles)
  end

  test "can view boards without logging in" do
      get boards_path
      assert_template 'boards/index'
      get board_path(@thebeatles)
      assert_template 'boards/show'
      assert_select 'title',    full_title(@thebeatles.name.upcase)
  end

  test "must log in to edit board" do
    get edit_board_path(@thebeatles)
    follow_redirect!
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "user can create a board" do
    log_in_as(@ringo)
    get new_board_path
    assert_difference 'Board.count' do
      post boards_path, params: { board: { name: "The Allstars",
                                           info: "checkout my new band" } }
    end
    follow_redirect!
    assert_not flash.empty?
    assert_template 'boards/show'
  end

  test "should redirect edit when logged in as non admin" do
    log_in_as(@ringo)
    get edit_board_path(@thebeatles), params: { id: @thebeatles.id }
    assert_redirected_to root_url
  end

  test "admin view edit board" do
    log_in_as(@john)
    get edit_board_path(@thebeatles), params: { id: @thebeatles.id }
  end

  test "only admin can edit board" do
    # log in non admin
    log_in_as(@ringo)
    get board_path(@thebeatles)
    get edit_board_path(@thebeatles)
    follow_redirect!
    assert_template 'static_pages/home'
    delete logout_path
    # log in as admin
    log_in_as(@john)
    get board_path(@thebeatles)
    get edit_board_path(@thebeatles)
    assert_template 'boards/edit'
    newinfo = "we just broke up."
    patch board_path(@thebeatles), params: { board: { name: "The Beatles",
                                                 info: newinfo } }
    assert_redirected_to @thebeatles
    assert_not flash.empty?
    @thebeatles.reload
    assert_equal newinfo, @thebeatles.info
  end


end
