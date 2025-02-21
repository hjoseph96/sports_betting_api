class PlayerSeeder
  def initialize
    @client = SportsGameOddsClient.new
  end

  def self.create_players
    self.new.create_players
  end

  def create_players
    @teams = Team.all

    next_cursor = nil
    @teams.each do |t|
      loop do
        response = @client.players(t.team_id, next_cursor: next_cursor)

        next_cursor = response['nextCursor']

        break if response['data'].nil?

        response['data'].each do |p|
          next if Player.exists?(player_id: t['playerID'])

          attrs = {
            team_id: t.id,
            player_id: p['playerID'],
            position: p['position'],
            names: p['names'],
            aliases: p['aliases'],
            school: p['school'],
            age: p['age'],
            birthday: p['birthday'],
            nationality: p['nationality'],
            weight: p['weight'],
            height: p['height'],
            jersey_number: p['jerseyNumber']
          }
          attrs.merge!({ years_in_league: p['yearsInLeague'] }) if p['yearsInLeague'].present?
          attrs.merge!({ team_group: p['teamGroup'] }) if p['teamGroup'].present?

          player = Player.create(attrs)

          player_name = player.names['display']
          puts "CREATED PLAYER: #{player_name} for #{player.team.display_name} in #{player.team.league.short_name}"
        end

        break if next_cursor.nil?
      end
    end


  end
end