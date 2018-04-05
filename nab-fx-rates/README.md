# NAB fx-rates

Assuming an `NAB_SANDBOX_API_KEY` is present and `curl` and `jq` are installed.

  ```
  curl -H "x-nab-key:${NAB_SANDBOX_API_KEY}" https://sandbox.api.nab/v2/fxrates?v=1 \
    | jq ".[].fxRates[] | select(.buyCurrency==\"CNY\" or .buyCurrency==\"RMB\" or .buyCurrency==\"NZD\")"
  ```

  returns NZD and CNY suggesting that they do not support RMB

  ```
  {
    "buyCurrency": "NZD",
    "sellCurrency": "AUD",
    "currentBuyRate": "1.11",
    "currentSellRate": "1.09",
    "previousBuyRate": "1.06",
    "previousSellRate": "1.02"
  }
  {
    "buyCurrency": "CNY",
    "sellCurrency": "AUD",
    "currentBuyRate": "5.0803",
    "currentSellRate": "4.1888",
    "previousBuyRate": "0.2358",
    "previousSellRate": "0.2358"
  }
  ```

Also the only `sellCurrency` is `AUD`

