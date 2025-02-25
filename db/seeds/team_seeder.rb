class TeamSeeder
  def initialize
    @client = SportsGameOddsClient.new
  end

  def self.create_teams
    self.new.create_teams
  end

  def create_teams
    @leagues = League.order(created_at: :asc)

    @leagues.each do |l|
      parse_response(l)
    end
  end

  def parse_response(league)
    next_cursor = nil

    loop do
      response = @client.teams(league.short_name, next_cursor: next_cursor)

      if response.try(:[], 'error') == 'Rate limit exceeded'
        sleep 70
        response = @client.teams(league.short_name, next_cursor: next_cursor)
      end

      next_cursor = response['nextCursor']

      break if response['data'].nil?

      response['data'].each do |t|
        next if Team.exists?(team_id: t['teamID'])

        attrs = {
          league_id: league.id,
          team_id: t['teamID']
        }

        attrs.merge!({ names: t['names'] }) if t['names'].present?
        attrs.merge!({ colors: t['colors'] }) if t['colors'].present?
        attrs.merge!({ standings: t['standings'] }) if t['standings'].present?

        team = Team.create(attrs)

        team_name = team.names['long'] || team.names['medium'] || team.names['short']

        puts "CREATED TEAM: #{team_name} for #{league.short_name}"
      end

      break if next_cursor.nil?
    end
  end
end
