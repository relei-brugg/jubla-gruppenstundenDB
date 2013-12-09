class CreateSeasonCategories < ActiveRecord::Migration
  def change
    create_table :season_categories do |t|
      t.string :name
    end
  end
end
