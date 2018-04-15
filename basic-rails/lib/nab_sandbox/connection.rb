require 'faraday'
require 'json'

class Connection
  BASE = 'https://sandbox.api.nab/v2/'

  def self.api
    Faraday.new(url: BASE) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['x-nab-key'] = ENV['NAB_SANDBOX_API_KEY']
    end
  end
end
