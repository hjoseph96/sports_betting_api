class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players, id: :uuid do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid
      t.string :position
      t.string :player_id
      t.jsonb :names
      t.string :aliases, array: true, default: []
      t.integer :years_in_league
      t.string :school
      t.integer :age
      t.datetime :birthday
      t.string :nationality
      t.string :weight
      t.string :height
      t.string :jersey_number
      t.string :team_group

      t.timestamps
    end
    add_index :players, :position
    add_index :players, :player_id
    add_index :players, :jersey_number
    add_index :players, :team_group
  end
end
