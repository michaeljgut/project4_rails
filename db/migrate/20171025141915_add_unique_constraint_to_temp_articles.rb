class AddUniqueConstraintToTempArticles < ActiveRecord::Migration[5.1]
  def change
    add_index :temp_articles, [:url, :user_id], :unique => true
  end
end
