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
  # install QT
  brew install qt@5.5
  echo 'export PATH="$(brew --prefix qt@5.5)/bin:$PATH"' >> ~/.bashrc

  bundle
  rails server

  # this will follow the current flow
  open http://localhost:3000

  # test the same flow
  rspec

  # hit the fx-rates NAB api
  open http://localhost:3000/fx_rates
  open http://localhost:3000/fx_rates/CNY

  # hit the GraphiQL frontend
  open http://localhost:3000/graphiql

  # run a curl query against the GraphQL endpoint
  curl -X POST                                                              \
    -H "Content-Type: application/json"                                     \
    --data '{ "query": "{ fx_rates { buy_currency current_buy_rate } }" }'  \
    http://localhost:3000/graphql
  ```

## TODO

  **Michael**
  - [ ] add react.js
  - [ ] link react to graphql
  - [ ] move the basic alipay attempt into the rails app
  - [ ] add graphQL _queries with arguments_
    following [how to implement graphql in rails](https://blog.codeship.com/how-to-implement-a-graphql-api-in-rails/)

  **Untaken**
  - [ ] flesh out the flow [postcard_holidays_spec.rb](/spec/features/lifecycle_flows/postcard_holidays_spec.rb)
    to include all the actors like the holiday providers and our own app as
    well as a populated image search etc
  - [ ] add ember.js?
  - [ ] add styling, bootstrap?
    - styling
      [China web design trends 2015](https://www.smashingmagazine.com/2015/02/china-web-design-trends-2015/)
    - content placeholder (aka spinner) animated shimmer on content blocks
      [FB content placeholder deconstruction](https://cloudcannon.com/deconstructions/2014/11/15/facebook-content-placeholder-deconstruction.html)
  - [ ] deploy to Ali cloud
  - [ ] look into data from [Australian Tourism Data Warehouse](https://atdw.com.au/)
  - [ ] prep for hackathon [NAB apis](https://hackathon-docs.api.extnp.nab.com.au/) presumably not working till the weekend?
  - [ ] fix the error handling of NAB api requests
  - [ ] get the `protect_from_forgery` issue with graphql sorted [commit 3f472ff](https://github.com/saramic/the-cross-border-hackathon-2018/commit/3f472ff7e06df1746c65fac5383006fcbffd3a7d)
    - https://nvisium.com/resources/blog/2014/09/10/understanding-protectfromforgery.html
  - [ ] anything else to update to the way we use service object to fetch APIs
    - [Service Objects in Ruby on Rails…and you](https://hackernoon.com/service-objects-in-ruby-on-rails-and-you-79ca8a1c946e)
    - [USING SERVICES TO KEEP YOUR RAILS CONTROLLERS CLEAN AND DRY](https://www.engineyard.com/blog/keeping-your-rails-controllers-dry-with-services)
  - [ ] anything more on rails and graphql setup
    - [Building a GraphQL API in Rails — Part 1](https://medium.com/@DrawandCode/building-a-graphql-api-in-rails-part-1-a40aaf7e165f)
    - [Building a GraphQL API in Rails — Part 2: Start Coding](https://medium.com/@DrawandCode/building-a-graphql-api-in-rails-part-start-coding-8b1de6d75041)
    - https://github.com/rmosolgo/graphql-ruby
    - [graphql-ruby Tutorial - Introduction](https://www.howtographql.com/graphql-ruby/0-introduction/)
    - [Public GraphQL APIs](https://github.com/APIs-guru/graphql-apis)
  - [ ] what to learn from twitter users who seem to follow this hackathon
    - https://twitter.com/alibaba_cloud
    - https://twitter.com/NAB
    - https://twitter.com/stoneandchalk
    - https://twitter.com/alantsen
    - https://twitter.com/SmallTimeVC
    - https://twitter.com/philipdalidakis
    - https://twitter.com/nomisruption
    - https://twitter.com/Matt_Cenin
    - https://twitter.com/SarahGrace84
    - https://twitter.com/codeCrypto coder
    - https://twitter.com/felicia_coco

## Resources

  * common chinese names http://www.theworldofchinese.com/2014/07/the-most-popular-names-in-china-not-a-john-smith-in-sight/

