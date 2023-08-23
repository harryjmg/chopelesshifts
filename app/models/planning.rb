class Planning < ApplicationRecord
    include Hashid::Rails

    belongs_to :user, optional: true

    has_many :shifts, dependent: :destroy
    has_many :reservations, through: :shifts, dependent: :destroy
    has_many :users, through: :reservations

    validates :name, presence: true
    validates :planning_type, presence: true
    validates :state, presence: true

    before_save :set_publication_date, if: -> { state_changed? && state == 'available' }

    scope :weekly, -> { where(planning_type: 'weekly') }
    scope :available, -> { where(state: 'available') }

    # States : draft, ready, available, closed, archived

    DAYS = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"]

    
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

    def seats_left
        shifts.sum(:seats) - shifts.sum(:seats_taken)
    end
    
    def theme_color
        name.include?("hebdomadaire") ? "warning" : "success"
    end
    
    def description
        if planning_type == "permanent"
            "Ouvert en permanence pour que tu puisses t'entraîner."
        elsif planning_type == "daily"
            "Un planning d'entraînement publié tous les jours à 18h."
        elsif planning_type == "weekly"
            "Tous les samedis à 10h, bonne chance pour récupérer les créneaux."
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

    def self.create_planning(type, user=nil)
        name = "Planning #{type}"
        planning = Planning.create!(name: name, planning_type: type, state: "draft", user: user)
        Planning::DAYS.each do |day|
            Planning.last.shifts.create!(day: day, start_hour: "08:00", end_hour: "14:00", seats: rand(10..15))
            Planning.last.shifts.create!(day: day, start_hour: "14:00", end_hour: "21:00", seats: rand(3..8))
        end
        planning
    end

    def publish
        update(state: "available")
    end

    def hourly_rate
        return 9 if planning_type == "weekly"
        0
    end

    def earnings(user)
        hourly_rate * reservations.where(user_id: user.id).sum { |r| r.duration_in_hours }
    end

    def self.available_types
        ["permanent", "daily", "weekly"]
    end

    def is_recent
        published_at > 5.minutes.ago
    end

    private
    
    def set_publication_date
        self.published_at = Time.now
    end
    
end
