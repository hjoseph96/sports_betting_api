class Odds < ApplicationRecord
  belongs_to :event
  belongs_to :player, required: false

  has_many :stat_odds
  has_many :stats, through: :stat_odds

  has_many :parlay_bets
end
