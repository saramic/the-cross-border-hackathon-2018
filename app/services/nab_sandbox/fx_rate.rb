module NabSandbox
  class FxRate < Base
    attr_accessor :buy_currency,
                  :sell_currency,
                  :current_buy_rate,
                  :current_sell_rate,
                  :previous_buy_rate,
                  :previous_sell_rate
  end
  #   {
  #     "buyCurrency" : "ZAR",
  #     "sellCurrency" : "AUD",
  #     "currentBuyRate" : "11.5594",
  #     "currentSellRate" : "10.6498",
  #     "previousBuyRate" : "9.624",
  #     "previousSellRate" : "8.726"
  #   }
end

