class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :asana_id
      t.datetime :created_at
      t.string :type
      t.string :text
      t.integer :created_by_id

      t.timestamps
    end
  end
end
