require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title("#{@user.email}&#39;s Profile")
    assert_select 'h1', text: @user.email
    assert_select 'h1>img.gravatar'
  end
end