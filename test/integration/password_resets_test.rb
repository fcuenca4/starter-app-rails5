require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:test_user)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Empty Email
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    assert_select "div.alert"
    assert_select "div.alert-danger"
    assert_select "button.close"
    assert_select "div#flash_danger", "Email address can't be empty"
    # Incorrectly formatted email
    post password_resets_path, params: { password_reset: { email: "foo@bar" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    assert_select "div.alert"
    assert_select "div.alert-danger"
    assert_select "button.close"
    assert_select "div#flash_danger", "Email address incorrectly formatted"
    # Email not found
    post password_resets_path, params: { password_reset: { email: "foo@bar.com" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    assert_select "div.alert"
    assert_select "div.alert-danger"
    assert_select "button.close"
    assert_select "div#flash_danger", "Email address not found"
    # Valid email
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_path
    # Password reset form
    user = assigns(:user)
    # Wrong email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_path
    # Inactive user
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_path
    user.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to root_path
    # Right email, right token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    # Invalid password & confirmation
    patch password_reset_path(user.reset_token), params: { email: user.email, user: { password: "foobaz10", password_confirmation: "bazfoo10" } }
    assert_select 'div#error_explanation'
    # Empty password
    patch password_reset_path(user.reset_token), params: { email: user.email, user: { password: "", password_confirmation: "" } }
    assert_select 'div#error_explanation'
    # Valid password & confirmation
    patch password_reset_path(user.reset_token), params: { email: user.email, user: { password: "foobaz10", password_confirmation: "foobaz10" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
    assert_nil user.reload.reset_digest
    assert_nil user.reload.reset_sent_at
  end

  test "expired token" do
    get new_password_reset_path
    post password_resets_path, params: { password_reset: { email: @user.email } }
    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@user.reset_token), params: { email: @user.email, user: { password: "barfoo10", password_confirmation: "barfoo10" } }
    assert_response :redirect
    follow_redirect!
    assert_match /expired/i, response.body
  end
end