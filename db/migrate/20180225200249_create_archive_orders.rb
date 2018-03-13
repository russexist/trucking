class CreateArchiveOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :archive_orders do |t|
      t.integer :price
      t.integer :weight
      t.text :comment
      t.integer :user_id
      t.integer :status
      t.integer :driver_id
      t.datetime :date
      t.string :start_point
      t.string :destination_point

      t.timestamps
    end
  end
end
