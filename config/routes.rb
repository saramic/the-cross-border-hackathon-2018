Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  root 'high_voltage/pages#show', id: 'root'

  resources :fx_rates, only: %w(show index)
  resources :locations, only: %w(show)
  resources :alipay, only: :show
end
