class GetData
  def self.perform
    truncate_data
    get_users
    get_projects
    get_tasks
    get_stories
    create_sections
  end

  def self.truncate_data
    Project.destroy_all
    Assignee.destroy_all
    Section.destroy_all
    Story.delete_all
    Task.delete_all
  end

  def self.get_users
    Asana::User.all.each do |u|
      Assignee.create(:asana_id => u.id, :name => u.name)
    end
  end

  def self.get_projects
    Asana::Project.all.each do |p|
      Project.create(:asana_id => p.id, :name => p.name)
    end
  end

  def self.get_tasks
    Project.all.each do |project|
      asana_project = Asana::Project.find(project.asana_id)
      asana_project.tasks.each do |task|
        t = Asana::Task.find(task.id)
        Task.create(:asana_id => t.id, :project_id => project.id, :name => t.name, :notes => t.notes,  :due_on => t.due_on) 
      end
    end
  end

  def self.get_stories
    Task.all.each do |t|
      asana_task = Asana::Task.find(t.asana_id)
      asana_task.stories.each do |s|
        Story.create(:asana_id => s.id, :created_at => s.created_at, :story_type => s.type, :text => s.text, :task_id => t.id, :created_by_id => Assignee.find_by_asana_id(s.created_by.id).id)
      end
    end
  end

  def self.create_sections
    Project.sections.each do |s|
      Section.create(:name => s)
    end
  end
end
