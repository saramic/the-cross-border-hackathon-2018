Rails.application.routes.draw do
  root 'high_voltage/pages#show', id: 'root'

  resources :fx_rates, only: %w(show index)
end
