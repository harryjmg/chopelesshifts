class Publication < ApplicationRecord

    def is_recent
        created_at > 5.minutes.ago
    end
    
end