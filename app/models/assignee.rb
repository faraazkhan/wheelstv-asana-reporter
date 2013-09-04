class Assignee < ActiveRecord::Base
  attr_accessible :asana_id, :name
  has_many :stories, :foreign_key => :created_by_id
end
