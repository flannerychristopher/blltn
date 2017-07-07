require 'test_helper'

class UserAvatarTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
  end

  test "user avatar interface" do
    log_in_as(@user)
    follow_redirect!
    assert_select 'section.user_info'
    get edit_user_path(@user)
    assert_select 'input[type=file]'
    # invalid info for edit
    patch user_path(@user), params: { user: { name: "" } }
    assert_select 'div#error_explanation'
    # valid submission
    avatar = fixture_file_upload('test/fixtures/johnlennon.jpg', 'image/jpg')
    patch user_path(@user), params: { user: { avatar: avatar } }
    follow_redirect!
    assert_select 'div.alert-success'
    assert_select 'img'
    # assert @user.avatar?
  end

end
