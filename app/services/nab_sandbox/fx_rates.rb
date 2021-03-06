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

    CACHE_DEFAULTS = { expires_in: 7.days, force: false }

    def self.fetch(clear_cache)
      cache = CACHE_DEFAULTS.merge({ force: clear_cache })
      response = Request.where('fxrates?v=1', cache)
      fx_rates_response = response.fetch('fxRatesResponse')
      fx_rates = FxRates.new(fx_rates_response["fxRates"], fx_rates_response["lastUpdatedDate"])
      errors = response["status"] unless response["status"]["code"] == 'API-200'
      [ fx_rates, errors ]
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

