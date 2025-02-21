class ParlayBet < ApplicationRecord
  enum :status, [ :pending, :won, :lost ], default: :pending

  belongs_to :parlay
  belongs_to :event
  belongs_to :odds

  def calculate_potential_payout
    book_odds = odds.book_odds || odds.open_book_over_under || odds.open_book_odds
    payout = wager_amount * book_odds
    profit = payout - wager_amount

    { total_payout: payout.round(2), profit: profit.round(2) }
  end
end
