class AddAge < ActiveRecord::Migration
  def change
    add_column :ideas, :age_min, :integer
    add_column :ideas, :age_max, :integer
    drop_table :age_categories
    drop_table :age_categories_ideas
  end
end
