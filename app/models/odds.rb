class Odds < ApplicationRecord
  belongs_to :event

  has_many :odds_players
  has_many :players, through: :odds_players

  has_many :stat_odds
  has_many :stats, through: :stat_odds

  has_many :parlay_bets
end
