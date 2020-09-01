class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.string :title
      t.boolean :type
      t.references :balance, foreign_key: true

      t.timestamps
    end
  end
end
