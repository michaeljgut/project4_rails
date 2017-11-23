class ChangeIndexOnTopics < ActiveRecord::Migration[5.1]
  def change
    remove_index :topics, [:name, :user_id]
    add_index :topics, [:name, :user_id, :search_unit], :unique => true
  end
end
