class Project < ActiveRecord::Base
  attr_accessible :asana_id, :name
  has_many :tasks, :dependent => :destroy
  has_many :sections, :dependent => :destroy

  def self.create_sections_for_projects
    sql = <<-SQL
          (SELECT DISTINCT stories.original_section AS "name", tasks.project_id from stories
          join tasks on stories.task_id = tasks.id
          where stories.original_section is not null
          ) 
          UNION 
          (SELECT DISTINCT stories.final_section AS "name", tasks.project_id from stories
          join tasks on stories.task_id = tasks.id
          where stories.final_section is not null)
          SQL
      
    all_sections_with_project_id = ActiveRecord::Base.connection.execute(sql)
    all_sections_with_project_id.each_hash do |hash|
      Section.create(hash)
    end
  end
end
