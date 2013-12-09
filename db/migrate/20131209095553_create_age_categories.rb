class CreateAgeCategories < ActiveRecord::Migration
  def change
    create_table :age_categories do |t|
      t.string :name
    end
  end
end
