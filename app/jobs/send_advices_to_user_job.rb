class SendAdvicesToUserJob < ApplicationJob
  queue_as :default

  def perform(user_id, last_known_level, reminder_count = 0)
    user = User.find(user_id)

    # Si son niveau n'a pas changé
    if last_known_level == user.current_level
      SendAdvicesToUserService.new(user_id).send_advice(last_known_level, reminder_count)
    
      reminder_count += 1

      if last_known_level == 6
        return if user.achievements.where(key: "apply_for_coding_accelerator").any?
        SendAdvicesToUserJob.set(wait: 7.days).perform_later(user_id, last_known_level, reminder_count)
        return if reminder_count > 2
      end

      if reminder_count <= 4
        SendAdvicesToUserJob.set(wait: 1.day).perform_later(user_id, last_known_level, reminder_count)
      elsif reminder_count <= 6
        SendAdvicesToUserJob.set(wait: 7.days).perform_later(user_id, last_known_level, reminder_count)
      elsif reminder_count <= 8
        SendAdvicesToUserJob.set(wait: 14.days).perform_later(user_id, last_known_level, reminder_count)
      end
    end
  end
end
