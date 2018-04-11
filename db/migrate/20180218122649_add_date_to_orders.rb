class AddDateToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :date, :date
  end
end
