class AddProjectIdToSections < ActiveRecord::Migration
  def change
    add_column :sections, :project_id, :integer
  end
end
