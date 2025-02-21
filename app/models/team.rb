class Team < ApplicationRecord
  belongs_to :league

  has_many :players

  def display_name
    names["long"] || names["short"]
  end
end
