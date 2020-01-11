class Project
  attr_accessor :title
  attr_reader :id

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @title =attributes.fetch(:title)
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING ID;")
    @id = result.first.fetch("id").to_i
  end

  def ==(other_project)
    self.title.eql?(other_project.title) && self.id.eql?(other_project.id)
  end

  def self.all
    results = DB.exec("SELECT * FROM projects;")
    projects = []
    results.each do |result|
      id = result.fetch("id").to_i
      title = result.fetch("title")
      projects.push(Project.new({:id => id, :title => title}))
    end
    projects
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects where id = #{id};").first
    title = project.fetch("title")
    Project.new({:id => id, :title => title})
  end

  def update(attributes)
    if (attributes.has_key?(:title)) && (attributes.fetch(:title) != nil)
      @title = attributes.fetch(:title)
      DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
    end
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{@id};")
  end

  def volunteers
    results = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id}")
    volunteers = []
    results.each do |result|
      name = result.fetch("name")
      id = result.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => @id, :id => id}))
    end
      volunteers
  end

end
