class RemoveUniqueIndexFromTopics < ActiveRecord::Migration[5.1]
  def change
    remove_index :topics, :name
    add_index :topics, [:name, :user_id], :unique => true
  end
end
