class FxRatesController < ApplicationController

  def index
    @fx_rates, @errors = query
  end

  def show
    @fx_rates, @errors = query
    @fx_rate = @fx_rates.find_by_currency(params[:id])
  end

  private
  def clear_cache
    params[:clear_cache].present?
  end

  def query
    NabSandbox::FxRates.fetch(clear_cache)
  end
end
