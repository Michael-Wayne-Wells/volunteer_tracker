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


end
