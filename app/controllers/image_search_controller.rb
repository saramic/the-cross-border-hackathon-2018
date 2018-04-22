class ImageSearchController < ApplicationController
  def index

  end

  def create
    @image_urls = params['image_urls'].split("\n")
    predict = Clarifai::Predict.predict(@image_urls[0])
    @tags = predict.tags
    render :result
  end
end