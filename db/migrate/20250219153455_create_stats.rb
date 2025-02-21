class CreateStats < ActiveRecord::Migration[8.0]
  def change
    create_table :stats, id: :uuid do |t|
      t.references :sport, null: false, foreign_key: true, type: :uuid
      t.string :stat_type
      t.string :stat_id
      t.jsonb :supported_levels
      t.jsonb :displays
      t.jsonb :supported_sports
      t.boolean :can_decrease
      t.string :description
      t.boolean :is_score_stat
      t.jsonb :units

      t.timestamps
    end
    add_index :stats, :stat_type
    add_index :stats, :stat_id
  end
end
