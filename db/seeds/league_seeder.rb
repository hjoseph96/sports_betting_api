class LeagueSeeder
  def initialize
    @client = SportsGameOddsClient.new
  end

  def self.create_leagues
    self.new.create_leagues
  end

  def create_leagues
    response = @client.leagues

    response['data'].each do |l|
      next if League.exists?(short_name: l['shortName'])

      sport_uuid = Sport.find_by(sport_id: l['sportID']).try(:id)

      l = League.create(
        sport_id: sport_uuid,
        name: l['name'],
        short_name: l['shortName']
      )

      puts "CREATED LEAGUE: #{l.short_name} for #{l.sport.name}"
    end
  end
end