# The Cross-Border Hackathon

Demo repo for ideas and proof of concepts around the April 2018 Hackathon
presented by Stone & Chalk in conjunction with NAB and Alibaba Cloud.

# Details

Hackathon site is http://thecrossborder.stoneandchalk.com.au/

## Challenges

### CHALLENGE 1: FOCUS ON AUSTRALIAN BUSINESSES SELLING TO CHINA
  Not all Australian businesses are fully leveraging their opportunity to
  export to Asia via e-commerce channels due to lack of knowledge of the Asian
  consumers, platforms, export procedures and regulations. How can we use APIs
  from NAB, Alibaba and other third parties to help?

### CHALLENGE 2: FOCUS ON CHINESE TOURISTS AND MIGRANTS COMING TO AUSTRALIA
  Chinese tourists and migrants have difficulty finding and engaging with all
  Australian services (including financial services) when traveling and seeking
  to establish themselves in Australia. How can we use APIs from NAB, Alibaba
  and other third parties to help?

## Approach

  * write a highlevel lifecycle flow as an acceptance spec
  * implement as hardcoded pages
  * style to make believeable
  * build out style/UX/API where greatest value can be demonstrated

## Dev setup

    ```sh
    bundle
    rails server

    # this will follow the current flow
    open http://localhost:3000

    # test the same flow
    rspec

    # hit the fx-rates NAB api
    open http://localhost:3000/fx-rates
    open http://localhost:3000/fx-rates/CNY

    # hit the GraphiQL frontend
    open http://localhost:3000/graphiql

    # run a curl query against the GraphQL endpoint
    curl -X POST                                                              \
      -H "Content-Type: application/json"                                     \
      --data '{ "query": "{ fx_rates { buy_currency current_buy_rate } }" }'  \
      http://localhost:3000/graphql
    ```

## Resources

  * common chinese names http://www.theworldofchinese.com/2014/07/the-most-popular-names-in-china-not-a-john-smith-in-sight/

