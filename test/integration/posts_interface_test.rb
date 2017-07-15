require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @john = users(:john)
    @post = posts(:revolver)
    @board = boards(:thebeatles)
  end

  test "should create post in standard way" do
    log_in_as(@john)
    assert_difference '@john.posts.count', 1 do
      post posts_path, params: {
                       post: { user: @john,
                               board_id: @board.id,
                               content: "test post" } }
    end
  end

  test "should create post with AJAX" do
    log_in_as(@john)
    assert_difference '@john.posts.count', 1 do
      post posts_path, xhr: true, params: {
                                  post: { user_id: @john.id,
                                          board_id: @board.id,
                                          content: "test post" } }
    end
  end

  test "should destroy post in standard way" do
    log_in_as(@john)
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
  end

  # test "should destroy post with AJAX" do
  #   log_in_as(@john)
  #   assert_difference '@john.posts.count', -1 do
  #     delete post_path(@post), xhr: true
  #   end
  # end

end
