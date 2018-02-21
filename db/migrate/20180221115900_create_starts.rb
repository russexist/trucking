class CreateStarts < ActiveRecord::Migration[5.1]
  def change
    create_table :starts do |t|
      t.string :starting_point
      t.float :start_latitude
      t.float :start_longitude

      t.timestamps
    end
  end
end
