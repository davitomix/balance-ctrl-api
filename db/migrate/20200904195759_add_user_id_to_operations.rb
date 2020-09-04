class AddUserIdToOperations < ActiveRecord::Migration[5.2]
  def change
    remove_column :operations, :balance_id
    add_reference :operations, :user, foreign_key: true
    add_column :operations, :balance_id, :bigint
  end
end
