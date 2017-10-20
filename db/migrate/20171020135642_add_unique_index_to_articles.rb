class AddUniqueIndexToArticles < ActiveRecord::Migration[5.1]
  def change
    add_index :articles, [:url, :user_id], :unique => true
  end
end
