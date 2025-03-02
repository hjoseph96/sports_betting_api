class CreateOddsPlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :odds_players do |t|
      t.references :odds, null: false, foreign_key: true, type: :uuid
      t.references :player, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
