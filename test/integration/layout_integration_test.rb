require 'test_helper'

class LayoutIntegrationTest < ActionDispatch::IntegrationTest
  test "should include confetti script in layout" do
    get root_path

    assert_select "script[src='https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js']", 1
  end
end
