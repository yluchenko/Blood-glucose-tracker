##### Prerequisites

The setups steps expect following tools installed on the system.

- Ruby [3.1.2]
- Rails [7.0.4]

##### 1. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
bundle exec rake db:seed
```

##### 2. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

##### 3. Run test

```ruby
rspec
```
