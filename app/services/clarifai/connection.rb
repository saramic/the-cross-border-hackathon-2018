require 'faraday'
require 'json'

module Clarifai
  class Connection
    BASE = 'https://api.clarifai.com/v2/models/'

    def self.api
      Faraday.new(url: BASE) do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
        faraday.headers['Authorization'] = "Key #{ENV['CLARIFAI_API_KEY']}"
        faraday.headers['Content-Type'] = 'application/json'
      end
    end
  end
end
