class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.integer :rating, default: 0
      t.integer :driver_id

      t.timestamps
    end
  end
end
