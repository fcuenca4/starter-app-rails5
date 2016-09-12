require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = Rails.application.config.application_name
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get about" do
    get page_path('about')
    assert_response :success
    assert_select "title", "#{@base_title} | About"
  end

  test "should get contact" do
    get page_path('contact')
    assert_response :success
    assert_select "title", "#{@base_title} | Contact"
  end

  test "should get sitemap" do
    get page_path('sitemap')
    assert_response :success
    assert_select "title", "#{@base_title} | Sitemap"
  end

  test "should get terms" do
    get page_path('terms')
    assert_response :success
    assert_select "title", "#{@base_title} | Terms &amp; Conditions"
  end
end