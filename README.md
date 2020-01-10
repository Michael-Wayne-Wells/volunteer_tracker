
  # _Volunteer Tracker_

  #### _Manage Project and Volunteers_

  #### By _**Michael Wells**_

  ## Description
  This application provides a resources for users to:
  * Add, edit, and delete projects to sql database
  * Add, edit, and delete volunteers associated with projects to database

  ## Setup/Installation Requirements

  Visit the Heroku deployment:


clone and open the file locally
in terminal run:

>$ git clone https://github.com/Michael-Wayne-Wells/ruby_builder.git

navigate to project folder and install gem bundles

>$ cd volunteer_tracker $ gem install bundler $ bundle install

start postgres(if not already) and duplicate database

>$ createdb volunteer_tracker
>$ psql volunteer_tracker < database_backup.sql
>$ postgres
>$ psql

run program script in terminal

>$ ruby app.rb

Open browser and go to https://localhost:4567

## Known Bugs

_No known bugs_

## Support and contact details

_If you have any issues with the program or want to reach out, email [mwells1286@gmail.com](href="mailto:mwells1286@gmail.com")_

## Technologies Used

_This program utilized:_
* _RUBY_
* _Sinatra_
* _HTML_
* _Heroku_
* _postgres_

_and was built on Atom_

### License

*Licensed under MIT license*

Copyright (c) 2019 **_Michael Wells_**
