class IdeaVisitAddDownloads < ActiveRecord::Migration
  def change
    add_column :idea_visits, :download, :boolean, default: false
  end
end
