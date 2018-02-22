class AddDestinationIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :destination_id, :integer
  end
end
