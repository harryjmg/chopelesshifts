require 'test_helper'

class AudioFileTest < ActiveSupport::TestCase
  test "should have celebrate.mp3 in public folder" do
    assert File.exist?(Rails.root.join('public', 'celebrate.mp3'))
  end
end
