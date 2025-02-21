class Player < ApplicationRecord
  belongs_to :team

  has_many :odds, class_name: 'Odds'
end
