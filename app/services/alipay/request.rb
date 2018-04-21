module Alipay
  class Request
    class << self
      def get(params)
        query_params_string = hash_to_sorted_query_params(params)
        query_params_string = [query_params_string, "sign=#{sign(query_params_string)}", "sign_type=MD5"].join('&')
        api.get("?#{query_params_string}")
      end

      def api
        Alipay::Connection.api
      end

      private

      def hash_to_sorted_query_params(hash)
        hash
            .sort
            .to_h
            .inject([]) { |ary, (k, v)| ary << "#{k}=#{v}" }
            .join('&')
      end

      def sign(sorted_query_string)
        Digest::MD5.hexdigest(sorted_query_string + ENV['ALIPAY_MD5'])
      end
    end
  end
end
