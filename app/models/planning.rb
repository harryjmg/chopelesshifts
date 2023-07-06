class Planning < ApplicationRecord
    has_many :shifts
    has_many :reservations, through: :shifts
    has_many :users, through: :reservations

    validates :name, presence: true
    validates :planning_type, presence: true
    validates :state, presence: true

    before_save :set_publication_date, if: -> { state_changed? && state == 'available' }

    # States : draft, ready, available, closed, archived

    NAMES = ["Rouge", "Bleu", "Vert", "Jaune", "Violet", "Orange", "Rose", "Brun", "Noir", "Blanc", 
        "Gris", "Cyan", "Magenta", "Marron", "Citron Vert", "Sarcelle", "Olive", "Corail", "Aubergine",
        "Bordeaux", "Lavande", "Cerise", "Indigo", "Turquoise", "Pêche", "Moutarde", "Fuchsia", "Mauve",
        "Châtain", "Rubis", "Saphir", "Améthyste", "Emeraude", "Topaze", "Opale", "Onyx", "Ebène", "Ivoire", 
        "Sable", "Jade", "Argent", "Or", "Cuivre", "Bronze", "Perle", "Pistache", "Caramel", "Vanille", "Cacao", 
        "Papaye", "Framboise", "Pamplemousse", "Kiwi", "Banane", "Amande", "Myrtille", "Canneberge", "Avocat", 
        "Prune", "Litchi", "Groseille", "Mangue", "Nougat", "Guimauve", "Réglisse", "Praline", "Café", "Chocolat", 
        "Miel", "Cerise", "Fraise", "Ananas", "Pomme", "Poire", "Abricot", "Pêche", "Prune", "Grenade", 
        "Framboise", "Melon", "Pastèque", "Raisin", "Mûre", "Myrtille", "Cassis", "Menthe", "Vanille", "Cannelle", 
        "Cardamome", "Curcuma", "Piment", "Poivre", "Safran", "Thym", "Anis", "Basilic", "Coriandre", "Gingembre", 
        "Jasmin", "Lavande", "Rose", "Tournesol", "Violette", "Camomille", "Chèvrefeuille", "Pivoine", "Muguet", 
        "Jonquille", "Glycine", "Bleuet"]

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
    
    def theme_color
        name.include?("hebdomadaire") ? "warning" : "success"
    end
    
    def description
        if planning_type == "permanent"
            "Ouvert en permanence pour que tu puisses t'entraîner."
        elsif planning_type == "daily"
            "Un autre planning d'entraînement publié tous les jours à 18h."
        elsif planning_type == "weekly"
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

    def self.create_planning(type)
        planning = Planning.create!(name: "#{NAMES.sample}", planning_type: type, state: "draft")
        Planning::DAYS.each do |day|
            Planning.last.shifts.create!(day: day, start_hour: "08:00", end_hour: "14:00", seats: rand(4..10))
            Planning.last.shifts.create!(day: day, start_hour: "14:00", end_hour: "21:00", seats: rand(1..5))
        end
        planning
    end

    def publish
        update(state: "available")
    end

    private
    
    def set_publication_date
        self.published_at = Time.now
    end
    
end
