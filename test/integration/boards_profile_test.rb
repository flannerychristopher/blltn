require 'test_helper'

class BoardsProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:john)
    @board = boards(:thebeatles)
  end

  test "profile displays all info correctly" do
    get board_path(@board)
    assert_template 'boards/show'
    assert_select 'title', full_title(@board.name.upcase)
    assert_select 'h1', text: @board.name
    assert_select 'p', text: @board.info
    assert_match @board.posts.count.to_s, response.body
  end

end
