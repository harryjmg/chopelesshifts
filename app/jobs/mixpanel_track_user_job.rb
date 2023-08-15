class MixpanelTrackUserJob < ApplicationJob
  queue_as :default

  def perform(event_name, properties = {})
    return unless MIXPANEL_TOKEN

    begin
      $mixpanel.track(properties[:email], event_name, properties)
    rescue => e
      Rails.logger.error "Error sending event to Mixpanel: #{e.message}"
    end
  end
end
