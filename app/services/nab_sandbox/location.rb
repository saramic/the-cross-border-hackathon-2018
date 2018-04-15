module NabSandbox
  class Location < Base
    attr_accessor :api_struct_type,
                  :key,
                  :description,
                  :latitude,
                  :longitude

    def initialize(args)
      @api_struct_type = args['apiStructType']
      @key = args[@api_struct_type]['key']
      @description = args[@api_struct_type]['description']
      @latitude = args[@api_struct_type]['latitude']
      @longitude = args[@api_struct_type]['longitude']
    end
  end
end

