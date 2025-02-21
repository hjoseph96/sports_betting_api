class CreateStatOdds < ActiveRecord::Migration[8.0]
  def change
    create_table :stat_odds do |t|
      t.references :stat, null: false, foreign_key: true, type: :uuid
      t.references :odds, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
