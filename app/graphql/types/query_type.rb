Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :fx_rates, !types[Types::FxRateType] do
    description "FX rates"
    resolve ->(obj, args, ctx) {
      NabSandbox::FxRates.fetch(false)[0].fx_rates
    }
  end
end
