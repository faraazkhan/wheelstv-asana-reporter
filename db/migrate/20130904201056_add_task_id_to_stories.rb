class AddTaskIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :task_id, :integer
  end
end
