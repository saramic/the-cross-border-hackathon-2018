require 'faraday'
require 'json'

module Atdw
  class Connection
    BASE = "http://atlas.atdw-online.com.au"

    def self.api
      Faraday.new(url: BASE) do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
        faraday.headers['charset'] = 'UTF-8'
        faraday.headers['Content-Type'] = 'application/json'
      end
    end
  end
end
