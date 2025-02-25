require_relative './odds_seeder'

class EventSeeder
  def initialize
    @client = SportsGameOddsClient.new
  end

  def self.create_events
    self.new.create_events
  end

  def create_events
    @leagues = League.all

    next_cursor = nil
    @leagues.each do |l|
      loop do
        response = @client.events(l.sport.sport_id, l.short_name, 1.month.ago, next_cursor: next_cursor)

        if response.try(:[], 'error') == 'Rate limit exceeded'
          sleep 70
          response = @client.events(l.sport.sport_id, l.short_name, 1.month.ago, next_cursor: next_cursor)
        end

        next_cursor = response['nextCursor']

        break if response['data'].nil?

        response['data'].each do |e|
          attrs = {
            league_id: l.id,
            event_id: e['eventID'],
            info: e['info'],
            status: e['status'],
            results: e['results'],
            starts_at: DateTime.parse(e['status']['startsAt'])
          }

          unless e['teams'].nil?
            home_team = Team.find_by(team_id: e['teams']['home']['teamID'])
            attrs.merge({ home_team_id: home_team.id })

            away_team = Team.find_by(team_id: e['teams']['away']['teamID'])
            attrs.merge!({ away_team_id: away_team.id })
          end

          event = Event.create!(attrs)
          puts "CREATED EVENT: #{event.event_id}"

          OddsSeeder.create_odds(event, e['odds'])
        end

        break if next_cursor.nil?
      end
    end
  end
end
