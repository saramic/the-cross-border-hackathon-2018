module NabSandbox
  class Locations < Base
    attr_accessor :total_records,
                  :locations

    CACHE_DEFAULTS = { expires_in: 7.days, force: false }

    def self.fetch(query = {}, clear_cache)
      cache = CACHE_DEFAULTS.merge({ force: clear_cache })
      response = Request.where('locations', cache, query.merge(locationType: 'atm', v: 1))
      locations_response = response.fetch('locationSearchResponse')
      locations = Locations.new(locations_response["locations"], locations_response["totalRecords"])
      errors = response["status"] unless response["status"]["code"] == 'API-200'
      [ locations, errors ]
    end

    def initialize(locations, total_records)
      @locations = locations.map{ |location| Location.new(location) }
      @total_records = total_records
    end
  end
end

