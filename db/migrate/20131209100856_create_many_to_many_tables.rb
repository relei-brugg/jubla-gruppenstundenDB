class CreateManyToManyTables < ActiveRecord::Migration
  def change
    create_table :age_categories_ideas do |t|
      t.belongs_to :age_category
      t.belongs_to :idea
    end

    create_table :activity_categories_ideas do |t|
      t.belongs_to :activity_category
      t.belongs_to :idea
    end

    create_table :group_size_categories_ideas do |t|
      t.belongs_to :group_size_category
      t.belongs_to :idea
    end

    create_table :ideas_location_categories do |t|
      t.belongs_to :idea
      t.belongs_to :location_category
    end

    create_table :ideas_method_categories do |t|
      t.belongs_to :idea
      t.belongs_to :method_category
    end

    create_table :ideas_season_categories do |t|
      t.belongs_to :idea
      t.belongs_to :season_category
    end
  end
end
