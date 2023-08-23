class Publication < ApplicationRecord

    def is_recent
        published_at > 5.minutes.ago
    end
    
end