class ReportsController < ApplicationController
  def get_data
  end

  def create_report
    @assignees = Assignee.all
    @sections = Section.all
    @projects = Project.all
    if request.post?
      build_report(params)
      flash[:error] = "there was a problem with your request" if @report_generated == false
    end
  end

  private
  def build_report(params)
    begin
      @report_assignee = Assignee.find(params[:assignee_id])
      @report_section = Section.find(params[:section_id])
      @report_duration = params[:days].to_i rescue 0
      @report_project_id = params[:project_id].to_i
      @report_stories = Story.get_all_for(@report_project_id, @report_assignee, @report_section.name, @report_duration)
      @report_quota = params[:set_quota].to_i rescue 0
      @report_tasks_count = @report_stories.collect(&:task).count
      @report_remaining_tasks = @report_quota - @report_tasks_count
      @report_generated = true 
      @red_or_green = @report_remaining_tasks > 0 ? "red" : "green"
    rescue
      @report_generated = false
    end
  end
end
