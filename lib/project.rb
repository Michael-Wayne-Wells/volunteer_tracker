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
end
