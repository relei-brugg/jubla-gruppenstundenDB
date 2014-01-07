class CreateIdeaRatings < ActiveRecord::Migration
  def change
    create_table :idea_ratings do |t|
      t.integer :rating
      t.references :idea
      t.references :user

      t.timestamps
    end

    remove_column :ideas, :likes
    remove_column :ideas, :dislikes

  end
end
