class Story < ActiveRecord::Base
  attr_accessible :asana_id, :created_at, :created_by_id, :text, :story_type, :section_event, :task_id, :original_section, :final_section
  before_create :set_section_event
  belongs_to :task
  belongs_to :created_by, :class_name => 'Assignee'
  before_create :parse_sections_from_section_events

  def set_section_event
    if (self.text =~ /Moved from/ || self.text =~ /Moved into/) && self.story_type == 'system'
      self.section_event = true
    end
  end

  def self.section_events
    Story.where('section_event = ?', true)
  end

  def sections
    sections = self.task.project.sections.order("length(name)").collect{|s| Regexp.escape(s.name) } rescue []
    sections.join('|')
  end

  def parse_sections_from_section_events
    unless sections.empty?
      if self.section_event? && self.text =~ /Moved from/
        regex = /Moved from (#{sections}) to (#{sections})/
        match_data = self.text.match(regex).to_a
        self.original_section = match_data[1]
        self.final_section = match_data[2]
      elsif self.section_event? && self.text =~ /Moved into/
        regex = /Moved into (#{sections})/
        match_data = self.text.match(regex).to_a
        self.final_section = match_data[1]
      end
    end
  end

  def self.get_all_for(project_id, report_assignee_id, report_section_name, report_duration)
    report_start_time = report_duration.send(:days).send(:ago).beginning_of_day rescue Date.today.beginning_of_day
    project = Project.find project_id
    task_ids = project.tasks.collect(&:id).join(',')
    Story.where("created_by_id = ? AND final_section = ? AND created_at >= ? and task_id IN (?)", report_assignee_id, report_section_name, report_start_time, task_ids)
  end

end
