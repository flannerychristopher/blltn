require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    assert_equal full_title,          "BLLTN"
    assert_equal full_title("HELP"),  "HELP | BLLTN"
  end

end
