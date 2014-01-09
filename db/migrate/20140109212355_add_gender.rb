class AddGender < ActiveRecord::Migration
  def change
    add_column :ideas, :boys, :boolean
    add_column :ideas, :girls, :boolean
  end
end
