class OperationSerializer
  def serialize(operation)
    operation.serializable_hash
  end
end
