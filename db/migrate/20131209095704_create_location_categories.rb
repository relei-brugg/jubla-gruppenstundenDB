class CreateLocationCategories < ActiveRecord::Migration
  def change
    create_table :location_categories do |t|
      t.string :name
    end
  end
end
