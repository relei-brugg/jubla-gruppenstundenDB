class AddGroupSize < ActiveRecord::Migration
  def change
    add_column :ideas, :group_size_min, :integer
    add_column :ideas, :group_size_max, :integer
    drop_table :group_size_categories
    drop_table :group_size_categories_ideas
  end
end
