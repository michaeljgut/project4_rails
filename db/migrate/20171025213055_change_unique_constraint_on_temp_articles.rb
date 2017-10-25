class ChangeUniqueConstraintOnTempArticles < ActiveRecord::Migration[5.1]
  def change
    remove_index :temp_articles, [:url, :user_id]
    add_index :temp_articles, [:url, :user_id, :search_unit], :unique => true
  end
end
