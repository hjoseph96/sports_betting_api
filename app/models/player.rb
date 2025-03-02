class Player < ApplicationRecord
  belongs_to :team

  has_many :odds, class_name: "Odds"

  has_many :event_players
  has_many :events, through: :event_players
end
