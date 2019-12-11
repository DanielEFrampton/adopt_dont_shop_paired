# Adopt Don't Shop Paired Project
[Adopt Don't Shop Paired](https://adopt-dont-shop-paired.herokuapp.com/) is a paired programming project for Turing School of Software & Design's Back-End Engineering (BEE) program.

## Background and Description

"Adopt Don't Shop Paired" is a fictitious pet adoption platform where visitors can favorite pets and apply to adopt their newest furry friend. It builds off the previous solo project "Adopt Don't Shop." Ryan Allen and Daniel Frampton were paired to complete this project, and chose to use [Daniel's solo project](https://github.com/DanielEFrampton/adopt_dont_shop) as their starting point. Forty user stories were provided to guide its development--thirty-three required stories and seven optional ones--which are all implemented in this repo.

## Tools and Languages Used

This project was built in Rails 5.1.7 and utilized Ruby, PostgreSQL, HTML, CSS, and ActiveRecord. Atom was used as our IDE, and Github Projects was used for project management (see Projects tab of repo). [The project is deployed to Heroku](https://adopt-dont-shop-paired.herokuapp.com/), which was managed using the Heroku CLI. RSpec (with Capybara and Shoulda-Matchers gems) was used for test-driven development (TDD). DBeaver was used for dynamic schema visualization.

In order to build our familiarity with the Rails framework, we chose to hand-roll all routes, resources, models, views, and controllers rather than use Rails generators.

## Database Schema

![Datbase Schema](https://user-images.githubusercontent.com/40702808/70668626-5d267c80-1c31-11ea-935b-b5023d37529d.png)

## Test Coverage

SimpleCov was used to track test coverage, and our project has 100% test coverage. Feature tests were used to drive the development and test the functionality of all controllers and views, and unit tests for all models and model-level methods.

## Local Deployment

Follow these instructions in your -nix command line terminal:

1. Clone this repo:
    ```
    git clone git@github.com:DanielEFrampton/adopt_dont_shop_paired.git
    ```
1. Install required gems:
    ```
    bundle install
    bundle update
    ```
1. Start the database:
    ```
    rails db:{create,migrate,seed}
    ```
1. To run test suite and view test coverage:
    ```
    rspec
    open coverage/index.html
    ```
1. Start the Rails server:
    ```
    rails s
    ```
1. In your browser, navigate to [localhost:3000](localhost:3000).

### Skills Developed by Project

#### Rails
* Describe use cases for a model that inherits from ApplicationRecord vs. a PORO
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Make use of flash messages
* Use Inheritance from ApplicationController or a student created controller to store methods that will be used in multiple controllers
* Use POROs to logically organize code for objects not stored in the database

#### ActiveRecord and Databases
* Use built-in ActiveRecord methods to create queries that calculate, select, filter, and order data from a single table
* Describe database relationships and terms such as "Many to Many" and "Join Table"

#### Testing and Debugging
* Write feature tests utilizing Capybara
* Sad Path Testing
* Write model tests with RSpec including validations, and class and instance methods

#### Web Applications
* Explain how Cookies/Sessions are used to create and maintain application state
* Describe and implement ReSTful routing
* Identify use cases for, and implement non-ReSTful routes
* Identify the different components of URLs(protocol, domain, path, query params)
