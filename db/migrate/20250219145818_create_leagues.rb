class CreateLeagues < ActiveRecord::Migration[8.0]
  def change
    create_table :leagues, id: :uuid do |t|
      t.references :sport, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.string :short_name

      t.timestamps
    end
    add_index :leagues, :name
  end
end
