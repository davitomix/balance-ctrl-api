class CreateBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :balances do |t|
      t.bigint :user_id
      t.string :title
      t.bigint :total
      t.string :category

      t.timestamps
    end
  end
end
