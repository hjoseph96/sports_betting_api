class CreateParlays < ActiveRecord::Migration[8.0]
  def change
    create_table :parlays, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.decimal :wager_amount
      t.decimal :potential_payout
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :parlays, :wager_amount
    add_index :parlays, :potential_payout
    add_index :parlays, :status
  end
end
