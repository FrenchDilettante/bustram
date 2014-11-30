bustram-angers.fr
=================

[![Build Status](https://travis-ci.org/manudwarf/bustram.svg?branch=master)](https://travis-ci.org/manudwarf/bustram) [![Coverage Status](https://img.shields.io/coveralls/manudwarf/bustram.svg)](https://coveralls.io/r/manudwarf/bustram?branch=master)

Dev setup
---------

1. Run `bundle install` to install dependencies
2. Create a `config/database.yml` with the correct informations
3. Copy `config/secrets.yml.sample` to `config/secrets.yml`
4. Run `rake db:migrate` to create the database structure
5. Run `rake db:seed` to load the data from `db/data.zip`
6. Run `rails s`
7. Code!
