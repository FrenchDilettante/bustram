bustram-angers.fr
=================

[![Build Status](https://travis-ci.org/manudwarf/bustram.svg?branch=master)](https://travis-ci.org/manudwarf/bustram) [![Coverage Status](https://img.shields.io/coveralls/manudwarf/bustram.svg)](https://coveralls.io/r/manudwarf/bustram?branch=master)

Dev setup
---------

1. Run `bundle install` to install dependencies
2. Setup a PostgreSQL database and update `config/database.yml` if necessary
3. Run `rake db:migrate` to create the database structure
4. Run `rake db:seed` to load the data from `db/data.zip`
5. Run `rails s`
6. Code!
