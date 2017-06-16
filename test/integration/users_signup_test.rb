require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information and error messages" do
    get join_path
    assert_no_difference 'User.count' do
      post join_path, params: { user: { name:         "",
                                         email:        "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select   'form[action="/join"]'
    assert_select   'div#error_explanation'
    assert_select   'div.field_with_errors'
  end

  test "valid signup information" do
    get join_path
    assert_difference 'User.count', 1 do
      post join_path, params: { user: { name:         "John Lennon",
                                        email:        "john@thebeatles.com",
                                        password:               "foobar",
                                        password_confirmation:  "foobar" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not      flash.nil?
  end

end
