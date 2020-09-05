class OperationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :status, :user_id, :balance_id
end
