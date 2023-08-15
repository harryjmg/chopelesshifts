require 'mixpanel-ruby'

MIXPANEL_TOKEN = ENV['MIXPANEL_PROJECT_TOKEN']
$mixpanel = Mixpanel::Tracker.new(MIXPANEL_TOKEN)