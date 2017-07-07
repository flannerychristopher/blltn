require 'test_helper'

class BoardsShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
    @board = boards(:thebeatles)
  end

  test "can view boards without logging in" do
      get boards_path
      assert_template 'boards/index'
      get board_path(@board)
      assert_template 'boards/show'
      assert_select 'title',    full_title(@board.name.upcase)
  end



end
