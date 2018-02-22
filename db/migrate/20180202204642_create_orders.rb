class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :price
      t.integer :weight
      t.text :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
