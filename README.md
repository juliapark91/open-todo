# Open Todo

Open Todo is an externally usable API for a basic todo list application. This API will allow users to modify user accounts and todo items from the command line. for tracking events on websites. Integrate with web apps to track user activity and report results.

This app powers Open Todo at http://julia-open-todo.herokuapp.com/

## Getting Started

## Software requirements

- Rails 4.2.2

- Ruby 2.2.2p95

- PostgreSQL 9.3.x or higher

## Navigate to the Rails application

```
$ cd /path/to/rails/application
```

## Set configuration files

```
$ cp config/database.yml.template config/database.yml
$ cp config/initializers/mail.rb.template config/initializers/mail.rb
```

Note:  You may need to edit the above files as necessary for your system.

## Create the database

 ```
 $ pgstart
 $ rake db:create
 ```

## Migrating and seeding the database

```
$ rake db:migrate
$ rake db:seed
```

## Starting the local server

```
$ rails server

   or

$ rails s
```

## Production Deployment

  ```
  $ git push heroku master
  $ heroku run rake db:migrate
  ```
## Creating, deleting, updating with Curl
  ```
  User Creation:
  $ curl -u julia@example.com:123456 -d "user[username]=Sterling" -d "user[password]=Archer" http://localhost:3000/api/users/
  List Creation:
  $ curl -u julia@example.com:123456 -d "list[name]=Things to do today" -d "list[permissions]=private" http://localhost:3000/api/users/1/lists
  Item Creation:
  $ curl -u julia@example.com:123456 -d "item[name]=Dance if you want to" http://localhost:3000/api/lists/1/items

  User Deletion:
  $ curl -u julia@example.com:123456 -X DELETE http://localhost:3000/api/users/1/
  List Deletion:
  $ curl -u julia@example.com:123456 -X DELETE http://localhost:3000/api/users/1/lists/1
  Item Deletion:
  $ curl -u julia@example.com:123456 -X DELETE http://localhost:3000/api/lists/1/items/1

  Topic Permissions Update:
  $ curl -X PUT -u julia@example.com:123456 -d "list[permissions]=private" http://localhost:3000/api/users/1/lists/1
  Item Name Update:
  $ curl -X PUT -u julia@example.com:123456 -d "item[name]=Leave your friends behind" http://localhost:3000/api/lists/1/items/1

## Support

Bug reports and feature requests can be filed with the rest for the Ruby on Rails project here:

* {File Bug Reports and Features}[https://github.com/juliapark91/open-todo/issues]


## Copyright

copyright:: (c) Copyright 2015 Open Todo. All Rights Reserved.
