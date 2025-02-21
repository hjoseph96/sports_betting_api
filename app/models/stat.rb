class Stat < ApplicationRecord
  belongs_to :sport

  has_many :stat_oddse
  has_many :odds, through: :stat_odds, class_name: "Odds"
end
