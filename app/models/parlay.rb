class Parlay < ApplicationRecord
  include MathHelper

  after_create :calculate_potential_payout

  belongs_to :user
  has_many :parlay_bets
  validates :parley_bets, length: { minimum: 2, maximum: 12 }

  enum :status, [ :pending, :won, :lost ], default: :pending

  def calculate_potential_payout
    decimal_odds = parlay_bets.map do |bet|
      odds = bet.odds.book_odds || bet.odds.open_book_over_under || bet.odds.open_book_odds
      american_to_decimal(odds)
    end

    total_odds = decimal_odds.inject(:*)
    payout = wager_amount * total_odds
    profit = payout - wager_amount

    { total_payout: payout.round(2), profit: profit.round(2) }
  end
end
