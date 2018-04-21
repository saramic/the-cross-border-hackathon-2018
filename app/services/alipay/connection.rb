require 'faraday'
require 'json'

module Alipay
  class Connection
    BASE = 'https://mapi.alipay.com/gateway.do' # from demo code

    def self.api
      Faraday.new(url: BASE) do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
        # faraday.headers['Content-Type'] = 'application/json' # TODO will they return json?
      end
    end
  end
end
