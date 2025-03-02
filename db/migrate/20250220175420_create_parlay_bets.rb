class CreateParlayBets < ActiveRecord::Migration[8.0]
  def change
    create_table :parlay_bets, id: :uuid do |t|
      t.references :parlay, null: false, foreign_key: true, type: :uuid
      t.references :event, null: false, foreign_key: true, type: :uuid
      t.references :odds, null: false, foreign_key: true, type: :uuid
      t.integer :bet_type, null: false, default: 0
      t.string :selected_outcome
      t.integer :status

      t.timestamps
    end
    add_index :parlay_bets, :bet_type
    add_index :parlay_bets, :status
  end
end
