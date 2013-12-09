class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :location
      t.integer :duration_preparation
      t.integer :duration_total
      t.string :information
      t.string :material
      t.string :security
      t.string :remarks
      t.text :start
      t.text :main_part
      t.text :end
      t.integer :duration_start
      t.integer :duration_main_part
      t.integer :duration_end

      t.boolean :published, default: false

      t.integer :downloads, default: 0
      t.integer :likes, default: 0
      t.integer :dislikes, default: 0
      t.integer :views, default: 0

      t.references :user

      t.timestamps
    end
  end
end
