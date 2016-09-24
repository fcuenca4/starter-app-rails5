require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
    @activated_user = users(:other_user)
    @inactive_user = users(:inactive_user)
  end

  test "should redirect to root_path when user is not activated" do
    log_in_as(@user)
    get user_path(@inactive_user)
    assert_redirected_to root_path
  end

  test "should not redirect to root_path when user is activated" do
    log_in_as(@user)
    get user_path(@activated_user)
    assert_template 'users/show'
    assert_select "h1", "#{@activated_user.email}'s Profile"
  end
end