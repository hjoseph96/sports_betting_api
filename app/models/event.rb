class Event < ApplicationRecord
  belongs_to :league

  has_many :odds, class_name: "Odds"
end
