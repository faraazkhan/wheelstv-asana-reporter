class GetData
  @@failed_tasks = 0
  @@failed_stories = 0
  def self.perform
    @@failed_tasks = 0
    @@failed_stories = 0
    truncate_data
    get_users
    get_new_projects 
    get_tasks
    #create_sections ## deprecating this. Since sections are now entered manually
  end

  def self.truncate_data
    #Project.destroy_all # Projects now persist in the database
    Assignee.destroy_all
    #Section.destroy_all # Sections Now Persist in the database
    Story.delete_all
    Task.delete_all
  end

  def self.get_users
    Asana::User.all.each do |u|
      Assignee.create(:asana_id => u.id, :name => u.name) 
    end
  end

  def self.get_new_projects
    Asana::Project.all.each do |p|
      Project.create(:asana_id => p.id, :name => p.name) unless Project.find_by_asana_id(p.id)
    end
  end

  def self.get_tasks
    Project.all.each do |project|
	if project.id == 1232
      asana_project = Asana::Project.find(project.asana_id)
      asana_project.tasks.in_groups_of(40) do |group|
        group.each do |task|
          create_task_from(task, project)
        end
        sleep 30
      end
end
    end
  end

  def self.create_task_from(task, project)
    begin
      t = Task.create(:asana_id => task.id, :project_id => project.id, :name => task.name)
      task.stories.each do |story|
        t.stories.create(:asana_id => story.id, :created_at => story.created_at, :story_type => story.type, :text => story.text, :task_id => t.id, :created_by_id => Assignee.find_by_asana_id(story.created_by.id).id) 
      end
    rescue 
      @@failed_tasks += 1
      nil
    end
  end

  #def self.get_stories
    #Task.all.each do |t|
      #asana_task = Asana::Task.find(t.asana_id)
      #asana_task.stories.in_groups_of(45) do |group|
        #group.each do |s|
         #create_story_from(s,t)
        #end
        #sleep 30
      #end
    #end
  #end

  #def self.create_story_from(s, t)
    #begin
      #Story.create(:asana_id => s.id, :created_at => s.created_at, :story_type => s.type, :text => s.text, :task_id => t.id, :created_by_id => Assignee.find_by_asana_id(s.created_by.id).id)
    #rescue
      #@@failed_stories +=1
      #nil
    #end
  #end

  def self.create_sections
    Project.create_sections_for_projects
  end
end
