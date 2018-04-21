module NabSandbox
  class Request
    class << self
      def where(resource_path, cache_params, query = {}, options = {})
        response, status = get_json(resource_path, cache_params, query)
        raise ArgumentError.new(response) unless status == 200
        response
      end

      def get_json(root_path, cache_params, query = {})
        query_string = query.map { |k, v| "#{k}=#{v}" }.join("&")
        path         = query.empty? ? root_path : "#{root_path}?#{query_string}"

        response = Rails.cache.fetch("nab_sandbox/#{path}", cache_params) do
          api.get(path)
        end

        [JSON.parse(response.body), response.status]
      end

      def api
        NabSandbox::Connection.api
      end
    end
  end
end