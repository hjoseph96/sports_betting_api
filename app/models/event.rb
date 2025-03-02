class Event < ApplicationRecord
  belongs_to :league

  has_many :odds, class_name: "Odds"

  belongs_to :home_team, class_name: "Team", foreign_key: :home_team_id, optional: true
  belongs_to :away_team, class_name: "Team", foreign_key: :away_team_id, optional: true

  has_many :event_players
  has_many :players, through: :event_players
end
