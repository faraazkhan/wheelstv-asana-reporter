class ChangeAsanaIdToBigIntOnAllModels < ActiveRecord::Migration
  def change
    change_column :projects, :asana_id, :integer, :limit => 8
    change_column :assignees, :asana_id, :integer, :limit => 8
    change_column :tasks, :asana_id, :integer, :limit => 8
    change_column :stories, :asana_id, :integer, :limit => 8
  end
end
