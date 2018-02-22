class AddUserIdToStarts < ActiveRecord::Migration[5.1]
  def change
    add_column :starts, :user_id, :integer
  end
end
