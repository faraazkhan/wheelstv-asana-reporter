# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130905201354) do

  create_table "assignees", :force => true do |t|
    t.integer  "asana_id",   :limit => 8
    t.string   "name"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "asana_id",   :limit => 8
    t.string   "name"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "project_id"
  end

  create_table "stories", :force => true do |t|
    t.integer  "asana_id",         :limit => 8
    t.datetime "created_at",                    :null => false
    t.string   "story_type"
    t.string   "text"
    t.integer  "created_by_id"
    t.datetime "updated_at",                    :null => false
    t.boolean  "section_event"
    t.integer  "task_id"
    t.string   "original_section"
    t.string   "final_section"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "project_id"
    t.integer  "asana_id",    :limit => 8
    t.datetime "created_at",               :null => false
    t.datetime "modified_at"
    t.string   "name"
    t.text     "notes"
    t.integer  "assignee_id"
    t.boolean  "completed"
    t.date     "due_on"
    t.datetime "updated_at",               :null => false
  end

end
