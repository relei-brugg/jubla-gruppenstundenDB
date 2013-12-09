class CreateMethodCategories < ActiveRecord::Migration
  def change
    create_table :method_categories do |t|
      t.string :name
    end
  end
end
