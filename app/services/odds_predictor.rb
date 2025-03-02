require "pycall/import"

class OddsPredictor
  include PyCall::Import

  attr_reader :numpy

  ODDS_TYPES = %w[over/under moneyline spread]

  def initialize
    pyfrom :'sklearn.ensemble', import: :RandomForestClassifier
    pyfrom :'sklearn.model_selection', import: :train_test_split
    pyfrom :'sklearn.metrics', import: :accuracy_score

    @numpy = PyCall.import_module("numpy")
  end

  def self.predict_event_outcome(event)
  end
end
