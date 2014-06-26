class AddNotification < ActiveRecord::Migration
  def change
    add_column :users, :notifications, :boolean, default: false
  end
end
