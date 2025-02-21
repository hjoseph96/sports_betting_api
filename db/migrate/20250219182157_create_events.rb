class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events, id: :uuid do |t|
      t.string :event_id
      t.references :league, null: false, foreign_key: true, type: :uuid
      t.integer :event_type
      t.jsonb :info
      t.jsonb :status
      t.jsonb :results
      t.uuid :home_team_id
      t.uuid :away_team_id

      t.timestamps
    end
    add_index :events, :event_id
    add_index :events, :home_team_id
    add_index :events, :away_team_id
  end
end
