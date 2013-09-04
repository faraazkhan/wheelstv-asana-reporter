class AddSectionEventToStories < ActiveRecord::Migration
  def change
    add_column :stories, :section_event, :boolean
  end
end
