require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def setup
    @base_title = Rails.application.config.application_name
  end

  test "full title helper" do
    ['root', 'other'].each do |test_page|
      assert_equal full_title(test_page == 'root' ? "" : test_page.titleize), test_page == 'root' ? @base_title : "#{@base_title} | #{test_page.titleize}"
    end
  end
end