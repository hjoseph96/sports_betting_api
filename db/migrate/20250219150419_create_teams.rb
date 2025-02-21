class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams, id: :uuid do |t|
      t.references :league, null: false, foreign_key: true, type: :uuid
      t.string :team_id
      t.jsonb :names
      t.jsonb :colors
      t.jsonb :standings

      t.timestamps
    end
    add_index :teams, :team_id
  end
end
