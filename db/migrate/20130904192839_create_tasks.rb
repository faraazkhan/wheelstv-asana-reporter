class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.integer :asana_id
      t.datetime :created_at
      t.datetime :modified_at
      t.string :name
      t.text :notes
      t.integer :assignee_id
      t.boolean :completed
      t.date :due_on

      t.timestamps
    end
  end
end
