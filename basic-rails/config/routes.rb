Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  root 'high_voltage/pages#show', id: 'root'

  resources :fx_rates, only: %w(show index)
end
