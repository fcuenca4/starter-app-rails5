require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
  end

  test "layout links while not logged in" do
    {'root' => root_path, 'about' => page_path('about'), 'contact' => page_path('contact'), 'sitemap' => page_path('sitemap'), 'terms' => page_path('terms'),
     'log_in' => log_in_path, 'sign_up' => sign_up_path}.each do |test_page, path|
      get path
      case test_page
      when 'root'
        assert_template "pages/index"
        assert_select "title", full_title("")
      when 'log_in'
        assert_template "sessions/new"
        assert_select "title", full_title("Log in")
      when 'sign_up'
        assert_template "users/new"
        assert_select "title", full_title("Sign up")
      else
        assert_template "pages/#{test_page}"
        assert_select "title", full_title(test_page == "terms" ? "Terms &amp; Conditions" : test_page.titleize)
      end
      assert_select "a[href=?]", root_path, count: test_page == 'root' ? 4 : 3
      assert_select "a[href=?]", page_path('about')
      assert_select "a[href=?]", page_path('contact')
      assert_select "a[href=?]", page_path('sitemap')
      assert_select "a[href=?]", page_path('terms')
      assert_select "a[href=?]", log_in_path
      assert_select "a[href=?]", sign_up_path
      assert_select "a[href=?]", users_path, count: 0
      assert_select "a[href=?]", user_path(@user), count: 0
      assert_select "a[href=?]", edit_user_path(@user), count: 0
      assert_select "a[href=?]", log_out_path, count: 0
    end
  end

  test "layout links while logged in" do
    {'root' => root_path, 'about' => page_path('about'), 'contact' => page_path('contact'), 'sitemap' => page_path('sitemap'), 'terms' => page_path('terms'),
     'users' => users_path, 'profile' => user_path(@user), 'settings' => edit_user_path(@user)}.each do |test_page, path|
       log_in_as(@user)
       get path
       case test_page
       when 'root'
         assert_template "pages/index"
         assert_select "title", full_title("")
       when 'users'
         assert_template "users/index"
         assert_select "title", full_title("All Users")
       when 'profile'
         assert_template "users/show"
         assert_select "title", full_title("#{@user.email}&#39;s Profile")
       when 'settings'
         assert_template "users/edit"
         assert_select "title", full_title("Edit User")
       else
         assert_template "pages/#{test_page}"
         assert_select "title", full_title(test_page == "terms" ? "Terms &amp; Conditions" : test_page.titleize)
       end
       assert_select "a[href=?]", root_path, count: test_page == 'root' ? 4 : 3
       assert_select "a[href=?]", page_path('about')
       assert_select "a[href=?]", page_path('contact')
       assert_select "a[href=?]", page_path('sitemap')
       assert_select "a[href=?]", page_path('terms')
       assert_select "a[href=?]", log_in_path, count: 0
       assert_select "a[href=?]", sign_up_path, count: test_page == 'root' ? 1 : 0
       assert_select "a[href=?]", users_path
       assert_select "a[href=?]", user_path(@user)
       assert_select "a[href=?]", edit_user_path(@user)
       assert_select "a[href=?]", log_out_path
    end
  end
end