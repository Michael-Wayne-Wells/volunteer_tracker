class Volunteer
  attr_accessor :name, :project_id
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def ==(other_volunteer)
    (self.name == other_volunteer.name) && (self.id == other_volunteer.id)
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) values ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    results.each do |result|
      name = result.fetch("name")
      project_id = result.fetch("project_id").to_i
      id = result.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM volunteers WHERE id = #{id}").first
    project_id = result.fetch("project_id").to_i
    name = result.fetch("name")
    Volunteer.new({:name => name, :project_id => project_id, :id => id})
  end
end
