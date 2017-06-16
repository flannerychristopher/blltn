require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    # home page
    get root_path
    assert_template 'static_pages/home'
    assert_select   "a[href=?]",    root_path, count: 2
    assert_select   "a[href=?]",    help_path
    # help page
    get help_path
    assert_select   "title",        full_title("HELP")
    assert_select   "div#accordion"
    # join page
    get join_path
    assert_template 'users/new'
    assert_select   "title",        full_title("JOIN")
  end

end
