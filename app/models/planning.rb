class Planning < ApplicationRecord
    has_many :shifts
    has_many :reservations, through: :shifts
    has_many :users, through: :reservations

    validates :name, presence: true
    validates :planning_type, presence: true
    validates :state, presence: true

    # States : draft, ready, available, closed, archived

    def self.week_days
        "lundi mardi mercredi jeudi vendredi samedi dimanche".split(" ")
    end

    def morning_shifts
        shifts.where("start_hour < ?", "14:00").order(Arel.sql("CASE day WHEN 'lundi' THEN 1 WHEN 'mardi' THEN 2 WHEN 'mercredi' THEN 3 WHEN 'jeudi' THEN 4 WHEN 'vendredi' THEN 5 WHEN 'samedi' THEN 6 WHEN 'dimanche' THEN 7 END"))
    end

    def afternoon_shifts
        shifts.where("start_hour >= ?", "14:00").order(Arel.sql("CASE day WHEN 'lundi' THEN 1 WHEN 'mardi' THEN 2 WHEN 'mercredi' THEN 3 WHEN 'jeudi' THEN 4 WHEN 'vendredi' THEN 5 WHEN 'samedi' THEN 6 WHEN 'dimanche' THEN 7 END"))
    end
end
