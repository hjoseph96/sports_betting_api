class OddsSeeder
  def initialize
    @client = SportsGameOddsClient.new
  end

  def self.create_odds(event, odds)
    self.new.create_odds(event, odds)
  end

  def create_odds(event, odds)
    odds.each do |o|
      # Get the odds data JSON
      o = o.last

      stat_id = Stat.find_by(stat_id: o['statID']).id

      attrs = {
        event_id: event.event_id,
        stat_id: stat_id,
        odd_type: o['oddType'],
        odd_id: o['oddID'],
        opposing_odd_id: o['opposingOddID'],
        market_name: o['marketName'],
        period_id: o['periodID'],
        bet_type_id: o['betTypeID'],
        side_id: o['sideID'],
        started: o['started'],
        ended: o['ended'],
        cancelled: o['cancelled'],
        scoring_supported: o['scoringSupported'],
        by_bookmaker: o['byBookmaker'],
        book_odds_available: o['bookOddsAvailable'],
        fair_odds_available: o['fairOddsAvailable']
      }

      attrs.merge!({ player_id: Player.find_by(player_id:  o['playerID']).id }) if o['playerID'].present?
      attrs.merge!({ fair_odds: o['fairOdds'].to_f.round(10) }) if attrs[:fair_odds_available]
      attrs.merge!({ book_odds: o['bookOdds'].to_f.round(10) }) if attrs[:book_odds_available]

      attrs.merge!({ fair_over_under: o['fairOverUnder'].to_f.round(10) }) if o['fairOverUnder'].present?
      attrs.merge!({ open_fair_odds: o['openFairOdds'].to_f.round(10) }) if o['openFairOdds'].present?
      attrs.merge!({ open_book_over_under: o['openBookOverUnder'].to_f.round(10) }) if o['openBookOverUnder'].present?
      attrs.merge!({ fair_spread: o['fairSpread'].to_f.round(10) }) if o['fairSpread'].present?
      attrs.merge!({ book_spend: o['bookSpend'].to_f.round(10) }) if o['fairSpend'].present?
      attrs.merge!({ open_fair_spread: o['openFairSpread'].to_f.round(10) }) if o['openFairSpread'].present?
      attrs.merge!({ open_book_spread: o['openBookSpread'].to_f.round(10) }) if o['openBookSpread'].present?

      odds = Odds.create(attrs)

      event.odds << odds

      begin
        event.save!
      rescue PG::NumericValueOutOfRange
        binding.pry
      end

      puts "CREATED ODDS(#{odds.odd_id}) FOR EVENT(#{event.event_id})"
    end
  end
end
