require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/project')
require('./lib/volunteer')
require('pg')

DB = PG.connect({:dbname => "volunteer_tracker"})
also_reload('lib/**/*.rb')
set :show_exceptions, false

get("/") do
  redirect to("/projects")
end

error 404,500 do
  erb(:error)
end

get("/projects") do
  projects = Project.all
  unless projects.nil?
    @projects = projects
  else
    @projects = []
  end
  erb(:projects)
end

post("/projects") do
  if params[:title] =~ /^[a-z0-9\_\-]+\s?[+\s?a-z0-9\_\-]*\w$/i
    project = Project.new({:title => params[:title], :id => nil})
    project.save
    redirect to("/projects")
  else
    erb(:error)
  end
end

get('/projects/:id') do
  id = params[:id]
  @project = Project.find(id.to_i)
  @volunteers = @project.volunteers
  @show = params[:show]
  erb(:project)
end



get('/projects/:id/edit') do
  @show = true
  @project = Project.find(params[:id].to_i)
  @volunteers = @project.volunteers
  erb(:project)
end

patch('/projects/:id') do
  project = Project.find(params[:id].to_i)
  if params[:title] =~ /^[a-z0-9\_\-]+\s?[+\s?a-z0-9\_\-]*\w$/i
    project.update({:title => params[:title], :id => nil})
    @show = false
    @project = Project.find(params[:id].to_i)
    @volunteers = @project.volunteers
    erb(:project)
  else
    erb(:error)
  end
end

delete('/projects/:id') do
  project = Project.find(params[:id].to_i)
  project.delete
  @projects = Project.all
  erb(:projects)
end

get("/projects/:id/volunteers/:volunteer_id") do
  @volunteer = Volunteer.find(params[:volunteer_id])
  @project = Project.find(params[:id])
  erb(:volunteer)
end

patch("/projects/:id/volunteers/:volunteer_id") do
  volunteer = Volunteer.find(params[:volunteer_id])
  volunteer.update({:name => params[:name], :project_id => nil, :id => nil})
  @project = Project.find(params[:id])
  @volunteers = @project.volunteers
  erb(:project)
end

post("/projects/:id/volunteers/") do
  @project = Project.find(params[:id].to_i)
  vol_name = params[:vol_name]
  if vol_name =~ /^[a-z0-9\_\-]+\s?[+\s?a-z0-9\_\-]*\w$/i
    volunteer = (Volunteer.new({:name => vol_name, :project_id => @project.id, :id => nil}))
    volunteer.save
    @volunteers = @project.volunteers
    erb(:project)
  else
    erb(:error)
  end
end

delete("/projects/:id/volunteers/:volunteer_id") do
  volunteer = Volunteer.find(params[:volunteer_id].to_i)
  volunteer.delete
  @project = Project.find(params[:id].to_i)
  @volunteers = @project.volunteers
  erb(:project)
end
