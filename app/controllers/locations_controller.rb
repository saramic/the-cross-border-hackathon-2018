class LocationsController < ApplicationController

  def show
    (@locations, @errors) = NabSandbox::Locations.fetch({
        searchCriteria: :geo,
        swLat: params[:sw_lat],
        neLat: params[:ne_lat],
        neLng: params[:ne_lng],
        swLng: params[:sw_lng]
   }, true)
    render json: @locations.locations
  end
end
