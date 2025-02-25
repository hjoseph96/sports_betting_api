# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_20_175420) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "event_id"
    t.uuid "league_id", null: false
    t.integer "event_type"
    t.jsonb "info"
    t.jsonb "status"
    t.jsonb "results"
    t.uuid "home_team_id"
    t.uuid "away_team_id"
    t.datetime "start_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_team_id"], name: "index_events_on_away_team_id"
    t.index ["event_id"], name: "index_events_on_event_id"
    t.index ["home_team_id"], name: "index_events_on_home_team_id"
    t.index ["league_id"], name: "index_events_on_league_id"
  end

  create_table "leagues", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "sport_id", null: false
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_leagues_on_name"
    t.index ["sport_id"], name: "index_leagues_on_sport_id"
  end

  create_table "odds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.uuid "stat_id", null: false
    t.string "odd_type"
    t.string "odd_id", null: false
    t.string "opposing_odd_id"
    t.string "market_name"
    t.string "period_id"
    t.string "bet_type_id"
    t.string "side_id"
    t.boolean "started"
    t.boolean "ended"
    t.boolean "cancelled"
    t.boolean "book_odds_available"
    t.boolean "fair_odds_available"
    t.decimal "fair_odds", precision: 15, scale: 10
    t.decimal "book_odds", precision: 15, scale: 10
    t.boolean "scoring_supported"
    t.jsonb "by_bookmaker"
    t.decimal "fair_over_under", precision: 15, scale: 10
    t.decimal "open_fair_odds", precision: 15, scale: 10
    t.decimal "open_book_odds", precision: 15, scale: 10
    t.decimal "open_fair_over_under", precision: 15, scale: 10
    t.decimal "open_book_over_under", precision: 15, scale: 10
    t.decimal "fair_spread", precision: 15, scale: 10
    t.decimal "book_spend", precision: 15, scale: 10
    t.decimal "open_fair_spread", precision: 15, scale: 10
    t.decimal "open_book_spread", precision: 15, scale: 10
    t.uuid "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_odds_on_event_id"
    t.index ["odd_type"], name: "index_odds_on_odd_type"
    t.index ["player_id"], name: "index_odds_on_player_id"
    t.index ["stat_id"], name: "index_odds_on_stat_id"
  end

  create_table "parlay_bets", force: :cascade do |t|
    t.uuid "parlay_id", null: false
    t.uuid "event_id", null: false
    t.uuid "odds_id", null: false
    t.integer "bet_type", default: 0, null: false
    t.string "selected_outcome"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bet_type"], name: "index_parlay_bets_on_bet_type"
    t.index ["event_id"], name: "index_parlay_bets_on_event_id"
    t.index ["odds_id"], name: "index_parlay_bets_on_odds_id"
    t.index ["parlay_id"], name: "index_parlay_bets_on_parlay_id"
    t.index ["status"], name: "index_parlay_bets_on_status"
  end

  create_table "parlays", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.decimal "wager_amount"
    t.decimal "potential_payout"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["potential_payout"], name: "index_parlays_on_potential_payout"
    t.index ["status"], name: "index_parlays_on_status"
    t.index ["user_id"], name: "index_parlays_on_user_id"
    t.index ["wager_amount"], name: "index_parlays_on_wager_amount"
  end

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "team_id", null: false
    t.string "position"
    t.string "player_id"
    t.jsonb "names"
    t.string "aliases", default: [], array: true
    t.integer "years_in_league"
    t.string "school"
    t.integer "age"
    t.datetime "birthday"
    t.string "nationality"
    t.string "weight"
    t.string "height"
    t.string "jersey_number"
    t.string "team_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jersey_number"], name: "index_players_on_jersey_number"
    t.index ["player_id"], name: "index_players_on_player_id"
    t.index ["position"], name: "index_players_on_position"
    t.index ["team_group"], name: "index_players_on_team_group"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "sports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "sport_id"
    t.string "name"
    t.boolean "has_meaningful_home_away"
    t.integer "clock_type"
    t.string "base_periods", default: [], array: true
    t.string "extra_periods", default: [], array: true
    t.jsonb "meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sports_on_name"
    t.index ["sport_id"], name: "index_sports_on_sport_id"
  end

  create_table "stat_odds", force: :cascade do |t|
    t.uuid "stat_id", null: false
    t.uuid "odds_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["odds_id"], name: "index_stat_odds_on_odds_id"
    t.index ["stat_id"], name: "index_stat_odds_on_stat_id"
  end

  create_table "stats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "sport_id", null: false
    t.string "stat_type"
    t.string "stat_id"
    t.jsonb "supported_levels"
    t.jsonb "displays"
    t.jsonb "supported_sports"
    t.boolean "can_decrease"
    t.string "description"
    t.boolean "is_score_stat"
    t.jsonb "units"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sport_id"], name: "index_stats_on_sport_id"
    t.index ["stat_id"], name: "index_stats_on_stat_id"
    t.index ["stat_type"], name: "index_stats_on_stat_type"
  end

  create_table "teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "league_id", null: false
    t.string "team_id"
    t.jsonb "names"
    t.jsonb "colors"
    t.jsonb "standings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_teams_on_league_id"
    t.index ["team_id"], name: "index_teams_on_team_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.decimal "balance", precision: 15, scale: 2, default: "2000.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "leagues"
  add_foreign_key "leagues", "sports"
  add_foreign_key "odds", "events"
  add_foreign_key "odds", "players"
  add_foreign_key "odds", "stats"
  add_foreign_key "parlay_bets", "events"
  add_foreign_key "parlay_bets", "odds", column: "odds_id"
  add_foreign_key "parlay_bets", "parlays"
  add_foreign_key "parlays", "users"
  add_foreign_key "players", "teams"
  add_foreign_key "stat_odds", "odds", column: "odds_id"
  add_foreign_key "stat_odds", "stats"
  add_foreign_key "stats", "sports"
  add_foreign_key "teams", "leagues"
end
