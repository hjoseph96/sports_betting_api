class CreateOdds < ActiveRecord::Migration[8.0]
  def change
    create_table :odds, id: :uuid do |t|
      t.references :event, null: false, foreign_key: true, type: :uuid
      t.references :stat, null: false, foreign_key: true, type: :uuid
      t.string :odd_type
      t.string :odd_id, null: false
      t.string :opposing_odd_id
      t.string :market_name
      t.string :period_id
      t.string :bet_type_id
      t.string :side_id
      t.boolean :started
      t.boolean :ended
      t.boolean :cancelled
      t.boolean :book_odds_available
      t.boolean :fair_odds_available
      t.decimal :fair_odds, precision: 25, scale: 10
      t.decimal :book_odds, precision: 25, scale: 10
      t.boolean :scoring_supported
      t.jsonb :by_bookmaker
      t.decimal :fair_over_under, precision: 25, scale: 10
      t.decimal :open_fair_odds, precision: 25, scale: 10
      t.decimal :open_book_odds, precision: 25, scale: 10
      t.decimal :open_fair_over_under, precision: 25, scale: 10
      t.decimal :open_book_over_under, precision: 25, scale: 10
      t.decimal :fair_spread, precision: 25, scale: 10
      t.decimal :book_spend, precision: 25, scale: 10
      t.decimal :open_fair_spread, precision: 25, scale: 10
      t.decimal :open_book_spread, precision: 25, scale: 10
      t.references :player, null: true, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :odds, :odd_type
  end
end
