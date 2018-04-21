module Clarifai
  class Request
    class << self
      def outputs(model, data)
        api.post("#{model}/outputs", data)
      end

      def api
        Clarifai::Connection.api
      end
    end
  end
end
