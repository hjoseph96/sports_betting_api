class CreateEventPlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :event_players do |t|
      t.references :player, null: false, foreign_key: true, type: :uuid
      t.references :event, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
