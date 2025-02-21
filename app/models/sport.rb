class Sport < ApplicationRecord
  has_many :leagues
  has_many :sport_stats
  has_many :stats, through: :sport_stats

  enum :clock_type, %w[COUNTS_DOWN NO_CLOCK COUNTS_UP]
end
