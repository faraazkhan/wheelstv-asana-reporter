class Task < ActiveRecord::Base
  attr_accessible :asana_id, :assignee_id, :completed, :created_at, :due_on, :modified_at, :name, :notes, :project_id
  belongs_to :project
  has_many :stories, :dependent => :destroy
end
