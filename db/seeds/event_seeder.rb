require_relative './odds_seeder'

class EventSeeder
  def initialize
    @client = SportsGameOddsClient.new
    @leagues = League.all
  end

  def self.create_events
    seeder = self.new
    seeder.create_historical_events
    seeder.create_upcoming_events
  end

  def create_historical_events
    next_cursor = nil
    @leagues.each do |l|
      loop do
        response = @client.events(
          l.sport.sport_id, l.short_name, 2.months.ago, next_cursor: next_cursor, odds_available: false, finalized: true
        )

        if response.try(:[], 'error') == 'Rate limit exceeded'
          sleep 70
          response = @client.events(
            l.sport.sport_id, l.short_name, 2.months.ago, next_cursor: next_cursor, odds_available: false, finalized: true
          )
        end

        next_cursor = response['nextCursor']

        break if response['data'].nil?

        response['data'].each do |e|
          create_event(l.id, e)
        end

        break if next_cursor.nil?
      end
    end
  end

  def create_upcoming_events
    next_cursor = nil
    @leagues.each do |l|
      loop do
        response = @client.events(
          l.sport.sport_id, l.short_name, Date.today, next_cursor: next_cursor, odds_available: true, finalized: false
        )

        if response.try(:[], 'error') == 'Rate limit exceeded'
          sleep 70
          response = @client.events(
            l.sport.sport_id, l.short_name, Date.today, next_cursor: next_cursor, odds_available: true, finalized: false
          )
        end

        next_cursor = response['nextCursor']

        break if response['data'].nil?

        response['data'].each do |e|
          create_event(l.id, e)
        end

        break if next_cursor.nil?
      end
    end
  end

  private

  def create_event(league_id, event_data)
    if Event.exists?(event_id: event_data['eventID'])
      puts "Event(#{event_data['eventID']}) already exists..."
      return
    end

    attrs = {
      league_id: league_id,
      event_id: event_data['eventID'],
      info: event_data['info'],
      status: event_data['status'],
      results: event_data['results'],
      starts_at: DateTime.parse(event_data['status']['startsAt'])
    }

    if event_data['teams'].present?
      home_team = Team.find_by(team_id: event_data['teams']['home']['teamID'])
      attrs.merge!({ home_team_id: home_team.id })

      away_team = Team.find_by(team_id: event_data['teams']['away']['teamID'])
      attrs.merge!({ away_team_id: away_team.id })
    end

    event = Event.create!(attrs)
    puts "CREATED EVENT: #{event.event_id}"

    if event_data['players'].present?
      event_data['players'].keys.each do |player_data|
        p = Player.find_by(player_id: player_data['player_id'])

        unless p.nil?
          event.players << p

          event.save!
        end
      end
    end

    unless event_data['odds'].nil?
      OddsSeeder.create_odds(event, event_data['odds'])
    end
  end
end
