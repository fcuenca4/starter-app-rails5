require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { email: "foo@invalid", password: "foo", password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select "div#error_explanation"
    assert_select "div.alert"
    assert_select "div.alert-danger"
    assert_select "div", "The form was not saved because it contains 3 errors:"
    assert_select "ul.text-danger"
    assert_select "li", "Email is invalid"
    assert_select "li", "Password confirmation doesn't match Password"
    assert_select "li", "Password is too short (minimum is 8 characters)"
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { email: email, password: "", password_confirmation: "" } }
    assert_redirected_to @user
    follow_redirect!
    assert_select "div.alert"
    assert_select "div.alert-success"
    assert_select "button.close"
    assert_select "div#flash_success", "Profile updated"
    @user.reload
    assert_equal email, @user.email
    assert_equal session[:forwarding_url], nil
  end
end