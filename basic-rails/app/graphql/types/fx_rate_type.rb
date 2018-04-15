Types::FxRateType = GraphQL::ObjectType.define do
  name 'FxRate'

  field :buy_currency,        !types.String
  field :current_buy_rate,    !types.String
  field :current_sell_rate,   !types.String
  field :previous_buy_rate,   !types.String
  field :previous_sell_rate,  !types.String
  field :sell_currency,       !types.String
end
