module Atdw
  class Product
    def self.search(term)
      response = Atdw::Request.search(term)
      Product.new(response.body.gsub(/\x00/, ""))
    end

    attr_reader :response, :doc

    def initialize(response)
      @doc      = Nokogiri::XML.parse(response)
      @response = response
    end

    def images
      @doc.xpath('/atdw_search_response/products/product_record/product_image').map { |product_image| product_image.text }
    end
  end
end
