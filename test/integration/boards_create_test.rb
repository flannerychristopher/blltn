require 'test_helper'

class BoardsCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
  end

  test "must log in to create board with friendly forwarding"do
    # try to send new board params
    assert_no_difference 'Board.count' do
      post boards_path, params: { board: { name:   "TEST BOARD",
                                           info:   "a board for testing" } }
    end
    follow_redirect!
    assert_template 'sessions/new'

    # try to visit new board form
    get new_board_path
    follow_redirect!
    assert_not_nil session[:forwarding_url]
    assert_template 'sessions/new'

    # log in
    log_in_as(@user)
    assert_redirected_to new_board_path
    assert is_logged_in?

    #create board
    assert_difference 'Board.count', 1 do
      post boards_path, params: { board: { name:   "TEST BOARD",
                                            info:   "a board for testing" } }
    end
    follow_redirect!
    assert_template 'boards/show'
    assert_select "title",        full_title("TEST BOARD")
    assert_select "a[href=?]",    user_path(@user)
    assert_not flash.empty?
  end

  test "unsuccessful board create" do
    log_in_as(@user)
    get new_board_path
    assert_template 'boards/new'
    assert_no_difference 'Board.count' do
      post boards_path, params:{ board: { name: "",
                                          info: "" } }
    end
    assert_template 'boards/new'
    assert_select   'form[action="/boards"]'
    assert_select   'div#error_explanation'
    assert_select   'div.alert'
  end

end
