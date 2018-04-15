module NabSandbox
  class FxRates < Base
    attr_accessor :fx_rates,
                  :last_updated_date
    #{
    # "fxRatesResponse" : {
    #   "fxRates" : [ {
    #     "buyCurrency" : "ZAR",
    #     "sellCurrency" : "AUD",
    #     "currentBuyRate" : "11.5594",
    #     "currentSellRate" : "10.6498",
    #     "previousBuyRate" : "9.624",
    #     "previousSellRate" : "8.726"
    #   }, {
    #   ...
    #   "lastUpdatedDate" : "2017-01-18T03:25:12.601Z"
    # },
    # "status" : {
    #   "code" : "API-200",
    #   "message" : "Success"
    # }
    def self.fetch
      response = Request.where('fxrates?v=1')
      fx_rates_response = response.fetch('fxRatesResponse')
      fx_rates = FxRates.new(fx_rates_response["fxRates"], fx_rates_response["lastUpdatedDate"])
      [ fx_rates, response["status"] ]
      #[ response["status"] ]
    end

    def initialize(fx_rates, last_updated_date)
      @fx_rates = fx_rates.map{ |fx_rate| FxRate.new(fx_rate) }
      @last_updated_date = Time.parse(last_updated_date)
    end

    def find_by_currency(currency_string)
      @fx_rates.find { |fx_rate| fx_rate.buy_currency == currency_string }
    end

    def available_currencies
      @fx_rates.map { |fx_rate| fx_rate.buy_currency }
    end
  end
end

