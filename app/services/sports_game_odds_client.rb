# Implement pagination with cursor URL params

class SportsGameOddsClient
  include HTTParty

  base_uri "https://api.sportsgameodds.com/v2/"

  def initialize
    @options = { headers: { "X-API-KEY" => Rails.application.credentials.dig(:sports_game_odds_api_key) } }
  end

  def sports
    self.class.get("/sports", @options)
  end

  def leagues
    self.class.get("/leagues", @options)
  end

  def teams(league_id, next_cursor: nil)
    path = "/teams?leagueID=#{league_id}&limit=100"
    path += "&cursor=#{next_cursor}" unless next_cursor.nil?

    self.class.get(path, @options)
  end

  def players(team_id, next_cursor: nil)
    path = "/players?teamID=#{team_id}"
    path += "&cursor=#{next_cursor}" unless next_cursor.nil?

    self.class.get(path, @options)
  end

  def stats(sport_id)
    self.class.get("/stats?sportID=#{sport_id}", @options)
  end

  def events(sport_id, league_id, starts_after, next_cursor: nil, odds_available: true, finalized: false)
    path = "/events?sportID=#{sport_id}&leagueID=#{league_id}&startsAfter=#{starts_after}"
    path += "&oddsAvailable=#{odds_available}&finalized=#{finalized}&limit=100"
    path += "&cursor=#{next_cursor}" unless next_cursor.nil?

    self.class.get(path, @options)
  end
end
