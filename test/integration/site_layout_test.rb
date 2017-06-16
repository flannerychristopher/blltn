require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select   "a[href=?]",    root_path, count: 2
    assert_select   "a[href=?]",    help_path
    get help_path
    assert_select   "title",        full_title("HELP")
    assert_select   "div#accordion"
    get join_path
    assert_template 'users/new'
    assert_select   "title",        full_title("JOIN")
  end

end
