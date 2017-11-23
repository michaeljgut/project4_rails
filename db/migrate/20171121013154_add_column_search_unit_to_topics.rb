class AddColumnSearchUnitToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :search_unit, :integer
  end
end
