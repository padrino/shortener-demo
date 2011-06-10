# Padrino URL Shortener Demo #

## Generated Components

* Mongoid
* Haml
* SCSS
* Riot
* RR
* JQuery

## Setup

Make sure that you have MongoDB installed. Then run `bundle install`

## Running Demo

run the server by doing:

    bundle exec padrino start

and visit the main page at `http://localhost:3000/`

To use the admin interface, seed an account by running:

    bundle exec rake seed

## Running Test Suite

The test suite uses watchr for autotest. You can run it using:

    watchr test.watchr

You can activate the full suite by doing CTRL + \

or you can run the suite yourself with:

    bundle exec rake test
