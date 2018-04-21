class ClarifaiController < ApplicationController
  def index
    predict = Clarifai::Predict.predict(URI.unescape(params[:url]))
    render json: predict.tags_and_values
  end
end