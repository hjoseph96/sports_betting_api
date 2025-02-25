class Team < ApplicationRecord
  belongs_to :league

  has_many :players

  def display_name
    names["long"] || names["short"]
  end

  def events
    Event.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end
end
