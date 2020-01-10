require('sinatra')
require('sinatra/reloader')
require('pry')
require('./lib/project')
require('./lib/volunteer')
require('pg')

DB = PG.connect({:dbname => "volunteer_tracker"})

also_reload('lib/**/*.rb')
