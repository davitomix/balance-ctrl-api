class BalanceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :title, :total, :category
end
