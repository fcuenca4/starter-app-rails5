require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:test_user)
    @non_admin = users(:other_user)
  end

  test "index as admin with activated users including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'ul.pagination', count: 2
    assigns(:users).each do |user|
      assert user.activated?
      assert_select 'a[href=?]', user_path(user), text: user.email
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'Delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'Delete', count: 0
  end
end