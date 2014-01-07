class CreateIdeaVisits < ActiveRecord::Migration
  def change
    create_table :idea_visits do |t|
      t.references :idea
      t.string :ip

      t.timestamps
    end
  end
end
