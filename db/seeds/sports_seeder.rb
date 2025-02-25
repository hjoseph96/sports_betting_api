class SportsSeeder
  def initialize
    @client = SportsGameOddsClient.new
  end

  def self.create_sports
    self.new.create_sports
  end

  def create_sports
    response = @client.sports

    response['data'].each do |s|
      next if Sport.exists?(sport_id: s['sportID'])

      meta = {
        'pointWord' => s['pointWord'],
        'eventWord' => s['eventWord']
      }

      s = Sport.create(
        sport_id: s['sportID'],
        name: s['name'],
        clock_type: s['clockType'],
        has_meaningful_home_away:  s['hasMeaningfulHomeAway'],
        base_periods: s['base_periods'],
        extra_periods: s['extra_periods'],
        meta: meta
      )

      puts "CREATED SPORT: #{s.name}"
    end
  end
end
