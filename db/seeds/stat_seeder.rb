class StatSeeder
  def initialize
    @client = SportsGameOddsClient.new
  end

  def self.create_stats
    self.new.create_stats
  end

  def create_stats
    @sports = Sport.all

    @sports.each do |s|
      response = @client.stats(s.sport_id)

      if response.try(:[], 'error') == 'Rate limit exceeded'
        sleep 70
        response = @client.stats(s.sport_id)
      end

      next if response['data'].nil?

      response['data'].each do |sta|
        attrs = {
          sport_id: s.id,
          stat_id: sta['statID'],
          supported_levels: sta['supposedLevels'],
          displays: sta['displays'],
          supported_sports: sta['supportedSports'],
          can_decrease: sta['canDecrease'],
          is_score_stat: sta['isScoreStat'],
          units: sta['units']
        }

        attrs.merge!({ description: sta['description'] }) if sta['description'].present?

        statistic = Stat.create(attrs)

        puts "CREATED STAT: #{statistic.stat_id} for #{s.name}"
      end
    end
  end
end
