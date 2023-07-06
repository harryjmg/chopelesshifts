class Planning < ApplicationRecord
    has_many :shifts
    has_many :reservations, through: :shifts
    has_many :users, through: :reservations

    validates :name, presence: true
    validates :planning_type, presence: true
    validates :state, presence: true

    before_save :set_publication_date, if: -> { state_changed? && state == 'available' }

    # States : draft, ready, available, closed, archived
    
    def self.available_plannings
        Planning.where(state: "available").order(created_at: :desc).group_by(&:planning_type).map { |k, v| v.first }
    end
    
    def self.closed_plannings
        Planning.where(state: "closed").order(created_at: :desc)
    end
    
    def state_in_french
        if state == "draft"
            "Brouillon"
        elsif state == "ready"
            "Prêt"
        elsif state == "available"
            "Ouvert"
        elsif state == "closed"
            "Fermé"
        elsif state == "archived"
            "Archivé"
        end
    end
    
    def filling_rate
        return 0 if shifts.count == 0
        (shifts.sum(:seats_taken) / shifts.sum(:seats).to_f * 100).round(2)
    end
    
    def theme_color
        name.include?("hebdomadaire") ? "warning" : "success"
    end
    
    def description
        if name.include?("permanent")
            "Ouvert en permanence pour que tu puisses t'entraîner."
        elsif name.include?("journalier")
            "Un autre planning d'entraînement publié tous les jours à 18h."
        elsif name.include?("hebdomadaire")
            "Tous les samedis à 10h, bonne chance parce que vous êtes des centaines."
        end
    end
    
    def order_by_type
        case planning_type
        when "permanent"
            1
        when "daily"
            2
        when "weekly"
            3
        end
    end

    private
    
    def set_publication_date
        self.published_at = Time.now
    end
    
end
