class ImageSearchController < ApplicationController
  def index

  end

  def create
    @image_urls          = params['image_urls'].split("\n")
    predict              = Clarifai::Predict.predict(@image_urls[0])
    @tags                = predict.tags
    holiday_search_terms = ['surfing', 'koala', 'bridge']
    search_term          = nil

    koala_terms = ["mammal", "zoo", "wildlife", "nature", "fur", "animal", "cute", "wild", "marsupial", "endangered", "furry"]
    bridge_terms = ["bridge", "city", "opera house"]

    holiday_search_terms.each do |holiday_search_term|
      if (koala_terms & @tags).length > 0
        search_term = 'wildlife'
        break
      end
      if (bridge_terms & @tags).length > 0
        search_term = 'sydney harbour bridge'
        break
      end
      search_term = holiday_search_term if @tags.include?(holiday_search_term)
      break if search_term
    end

    search_term ||= 'surfing'
    search      = Atdw::Product.search(search_term)
    @images     = search.images
    render :result
  end
end