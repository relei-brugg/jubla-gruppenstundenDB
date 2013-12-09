class CreateGroupSizeCategories < ActiveRecord::Migration
  def change
    create_table :group_size_categories do |t|
      t.string :name
    end
  end
end
