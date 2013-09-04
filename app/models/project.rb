class Project < ActiveRecord::Base
  attr_accessible :asana_id, :name
  has_many :tasks, :dependent => :destroy

  def self.sections
    sql = "(SELECT DISTINCT original_section from stories) UNION (SELECT DISTINCT final_section from stories)"
    all_sections = ActiveRecord::Base.connection.execute(sql)
    sections = all_sections.to_a.flatten.uniq
    sections.compact
  end
end
