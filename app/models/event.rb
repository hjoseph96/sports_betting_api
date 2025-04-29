class Event < ApplicationRecord
  belongs_to :league

  has_many :odds, class_name: "Odds"

  belongs_to :home_team, class_name: "Team", foreign_key: :home_team_id, optional: true
  belongs_to :away_team, class_name: "Team", foreign_key: :away_team_id, optional: true

  has_many :event_players
  has_many :players, through: :event_players

  def self.where_team_id(team_id)
    Event.where('home_team_id = ? OR away_team_id = ?', team_id, team_id)
  end

  def home_or_away?(team_id)
    return 'home' if self.home_team_id == team_id
    return 'away' if self.away_team_id == team_id

    'neither'
  end
end

past_events.map do |e|
  home_or_away_key = e.home_or_away?(team.id)

  e.results['game'][home_or_away_key]['points']
end