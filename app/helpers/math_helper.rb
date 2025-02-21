module MathHelper
  def american_to_decimal(odds)
    if odds.positive?
      (odds / 100.0) + 1
    else
      (100.0 / odds.abs) + 1
    end
  end
end
