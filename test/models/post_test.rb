require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @john = users(:john)
    @board = boards(:thebeatles)
    @post = @john.posts.build(content: "Strawberry fields forever", board_id: @board.id )
  end

  test "post should be valid" do
    assert @post.valid?
  end

  test "user id must be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "board id must be present" do
    @post.board_id = nil
    assert_not @post.valid?
  end

  test "post content must be present" do
    @post.content = "      "
    assert_not @post.valid?
  end

  test "content should be at most 255 characters" do
    @post.content = "x" * 256
    assert_not @post.valid?
  end

  test "order should start with most recent" do
    assert_equal posts(:most_recent), Post.first
  end

end
