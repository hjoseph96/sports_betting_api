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

      if o['playerID'].present?
        binding.pry if Player.find_by(player_id: o['playerID']).nil?
        attrs.merge!({ player_id: Player.find_by(player_id:  o['playerID']).id })
      end
      attrs.merge!({ fair_odds: o['fairOdds'].to_f }) if attrs[:fair_odds_available]
      attrs.merge!({ book_odds: o['bookOdds'].to_f }) if attrs[:book_odds_available]

      attrs.merge!({ fair_over_under: o['fairOverUnder'] }) if o['fairOverUnder'].present?
      attrs.merge!({ open_fair_odds: o['openFairOdds'] }) if o['openFairOdds'].present?
      attrs.merge!({ open_book_over_under: o['openBookOverUnder'] }) if o['openBookOverUnder'].present?
      attrs.merge!({ fair_spread: o['fairSpread'] }) if o['fairSpread'].present?
      attrs.merge!({ book_spend: o['bookSpend'] }) if o['fairSpend'].present?
      attrs.merge!({ open_fair_spread: o['openFairSpread'] }) if o['openFairSpread'].present?
      attrs.merge!({ open_book_spread: o['openBookSpread'] }) if o['openBookSpread'].present?

      odds = Odds.create(attrs)

      event.odds << odds
      event.save!

      puts "CREATED ODDS(#{odds.odd_id}) FOR EVENT(#{event.event_id})"
    end
  end
end