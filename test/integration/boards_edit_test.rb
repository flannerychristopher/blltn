require 'test_helper'

class BoardsEditTest < ActionDispatch::IntegrationTest

  def setup
    @john = users(:john)
    @paul = users(:ringo)
    @wings = boards(:thebeatles)
  end

  test "must log in to edit board" do

  end

  test "only admin can edit board" do

  end

end
