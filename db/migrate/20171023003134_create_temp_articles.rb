class CreateTempArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :temp_articles do |t|
      t.string :title
      t.date :publication_date
      t.string :url
      t.integer :user_id
      t.integer :search_unit

      t.timestamps
    end
  end
end
