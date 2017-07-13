require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @post = posts(:revolver)
    @john = users(:john)
    @board = boards(:thebeatles)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post:{ content: "test post",
                                        user_id: @john.id,
                                        board_id: @board.id } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

end
