module Atdw
  class Request
    class << self
      def search(term)
        api.get("/api/atlas/products?key=#{ENV['ATDW_API_KEY']}&term=#{term}")
      end

      def api
        Atdw::Connection.api
      end
    end
  end
end
