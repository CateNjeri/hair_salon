# Hair Salon

#### A web app to practice database basics with Ruby.

#### By Catherine Njeri, Feb 2017

## Description

This app allows users to view, add, update and delete stylists and clients at a hair salon. Users may also assign clients to a stylist and view a list of clients for each stylist.  

## Technologies Used

* HTML
* CSS
* Bootstrap
* Ruby

## Gems Used:

* sinatra
* sinatra-contrib
* pry
* rspec
* capybara
* launchy

## Setup/Installation Requirements

* To replicate, clone this repository to your local hard drive using this link: https://github.com/CateNjeri/hair_salon.git

###Set up Databases in PSQL:
```
CREATE DATABASE hair_salon;
\c hair_salon;
CREATE TABLE stylists (id serial PRIMARY KEY, name varchar, station int);
CREATE TABLE clients (id serial PRIMARY KEY, name varchar, phone varchar, email varchar, stylist_id int);
CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;
```
###Install and Run Bundler:
```
$ gem install bundler
$ bundle
```
###Run the Sinatra application:
```
$ ruby app.rb
Navigate to `localhost:4567` with a browser
```
## Support and contact details

Please contact me with any questions, concerns, or ideas at njerikaris2@gmail.com

### License

Licensed under the MIT license

Copyright (c) 2017 **Cate Njeri**
