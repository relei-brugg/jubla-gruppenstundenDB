class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :rating

      t.references :idea
      t.references :user

      t.timestamps
    end
  end
end
