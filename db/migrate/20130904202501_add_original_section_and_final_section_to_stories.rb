class AddOriginalSectionAndFinalSectionToStories < ActiveRecord::Migration
  def change
    add_column :stories, :original_section, :string
    add_column :stories, :final_section, :string
  end
end
