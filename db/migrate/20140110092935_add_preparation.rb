class AddPreparation < ActiveRecord::Migration
  def change
    add_column :ideas, :preparation, :string
  end
end
