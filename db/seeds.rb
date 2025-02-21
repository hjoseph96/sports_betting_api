require_relative './seeds/sports_seeder'
require_relative './seeds/league_seeder'
require_relative './seeds/team_seeder'
require_relative './seeds/player_seeder'
require_relative './seeds/stat_seeder'
require_relative './seeds/event_seeder'

SportsSeeder.create_sports
LeagueSeeder.create_leagues
TeamSeeder.create_teams
StatSeeder.create_stats
PlayerSeeder.create_players
EventSeeder.create_events
