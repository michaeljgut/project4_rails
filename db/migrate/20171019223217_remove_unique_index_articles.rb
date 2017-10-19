class RemoveUniqueIndexArticles < ActiveRecord::Migration[5.1]
  def change
    remove_index :articles, :url
    add_index :articles, :url
  end
end
