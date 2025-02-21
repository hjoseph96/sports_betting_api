class CreateSports < ActiveRecord::Migration[8.0]
  def change
    enable_extension 'pgcrypto'
    create_table :sports, id: :uuid do |t|
      t.string :sport_id
      t.string :name
      t.boolean :has_meaningful_home_away
      t.integer :clock_type
      t.string :base_periods, array: true, default: []
      t.string :extra_periods, array: true, default: []
      t.jsonb :meta

      t.timestamps
    end
    add_index :sports, :sport_id
    add_index :sports, :name
  end
end
