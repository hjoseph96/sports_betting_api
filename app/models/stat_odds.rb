class StatOdds < ApplicationRecord
  belongs_to :stat
  belongs_to :odds, class_name: "Odds"
end
