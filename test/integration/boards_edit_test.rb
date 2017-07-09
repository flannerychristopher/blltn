require 'test_helper'

class BoardsEditTest < ActionDispatch::IntegrationTest

  def setup
    @john = users(:john)
    @ringo = users(:ringo)
    @board = boards(:thebeatles)
  end

  test "must log in to edit board" do
    get edit_board_path(@board)
    follow_redirect!
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "only admin can edit board" do
    # log in non admin
    log_in_as(@ringo)
    get board_path(@board)
    get edit_board_path(@board)
    follow_redirect!
    assert_template 'static_pages/home'
    delete logout_path
    # log in as admin
    log_in_as(@john)
    get board_path(@board)
    get edit_board_path(@board)
    assert_template 'boards/edit'
    newinfo = "we just broke up."
    patch board_path(@board), params: { board: { name: "The Beatles",
                                                 info: newinfo } }
    assert_redirected_to @board
    assert_not flash.empty?
    @board.reload
    assert_equal newinfo, @board.info
  end

end
