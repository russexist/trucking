class AddDriverIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :driver_id, :integer
  end
end
