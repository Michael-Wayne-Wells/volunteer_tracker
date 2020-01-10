require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/project')
require('./lib/volunteer')
require('pg')

DB = PG.connect({:dbname => "volunteer_tracker"})

also_reload('lib/**/*.rb')

get("/") do
  redirect to("/projects")
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
 title = params[:title]
 project = Project.new({:title => title, :id => nil})
 project.save
 redirect to("/projects")
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @show = params[:show]
  erb(:project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @project.update({:title => params[:title], :id => nil})
  @show = false
  erb(:project)
end
