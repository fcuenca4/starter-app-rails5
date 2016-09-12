require 'test_helper'

class UsersSignUpTest < ActionDispatch::IntegrationTest
  test "invalid sign_up information" do
    get sign_up_path
    assert_select 'form[action="/sign_up"]'
    assert_no_difference 'User.count' do
      post users_path, params: { user: { email: "user@invalid", password: "foo", password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select "div#error_explanation"
    assert_select "div.alert"
    assert_select "div.alert-danger"
    assert_select "div", "The form was not saved because it contains 3 errors:"
    assert_select "ul.text-danger"
    assert_select "li", "Email is invalid"
    assert_select "li", "Password confirmation doesn't match Password"
    assert_select "li", "Password is too short (minimum is 8 characters)"
  end

  test "valid sign_up information" do
    get sign_up_path
    assert_select 'form[action="/sign_up"]'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { email: "user@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    assert_select "div.alert"
    assert_select "div.alert-success"
    assert_select "button.close"
    assert_select "div#flash_success", "Welcome to #{Rails.application.config.application_name}!"
  end
end