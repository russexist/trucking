class CreateDestinations < ActiveRecord::Migration[5.1]
  def change
    create_table :destinations do |t|
      t.string :destination_point
      t.float :destination_latitude
      t.float :destination_longitude

      t.timestamps
    end
  end
end
