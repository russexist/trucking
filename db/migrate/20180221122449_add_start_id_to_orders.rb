class AddStartIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :start_id, :integer
  end
end
