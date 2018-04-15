class FxRatesController < ApplicationController

  def index
    @fx_rates, @errors = NabSandbox::FxRates.fetch
  end

  def show
    @fx_rates, @errors = NabSandbox::FxRates.fetch
    @fx_rate = @fx_rates.find_by_currency(params[:id])
  end
end
