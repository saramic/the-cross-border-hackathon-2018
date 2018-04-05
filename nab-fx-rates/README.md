# NAB APIs

Assuming an `NAB_SANDBOX_API_KEY` is present and `curl` and `jq` are installed.

# NAB fx-rates

Get current transfer rates

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

## NAB locations

get 2,939 **ATM** locations all at once

  ```{sh}
  curl -H "x-nab-key:${NAB_SANDBOX_API_KEY}" 'https://sandbox.api.nab/v2/locations?locationType=atm&v=1'
  ```

  returns
  ```{json}
  {
    "locationSearchResponse" : {
      "totalRecords" : 2939,
      "locations" : [ {
        "apiStructType" : "atm",
        "atm" : {
          "key" : "atm_2A08",
          "description" : "Riverside Shopping Centre",
          "latitude" : -35.353024,
          "longitude" : 149.2348171
        }
      }, {
        "apiStructType" : "atm",
        "atm" : {
          "key" : "atm_2A09",
          "description" : "Pavilion Plaza",
          "latitude" : -33.874797,
          "longitude" : 151.2067714
        }
      }, {
        "apiStructType" : "atm",
        "atm" : {
          "key" : "atm_2A10",
          "description" : "Wynyard Railway Station",
          "latitude" : -33.865363,
          "longitude" : 151.2052184
        }
      },
      ...
    }
  }
  ```
