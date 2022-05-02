##### Prerequisites

The setups steps expect following tools installed on the system.

I recommend using the ruby ​on rails installation guide from [gorails](https://gorails.com/setup/ubuntu/20.04).

- Github
- Ruby **3.0.0**
- Rails **6.1.4.1**
- PostgreSQL **12**
- Redis **5.0.7**

##### 1. Check out the repository

```bash
git clone git@github.com:PDS-UFAL/odados-ufal-api.git
```

##### 2. Create .env file

Copy the sample .env.example file and edit the environment variables as required.

```bash
cp .env.example .env
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rails db:create db:migrate db:seed
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can use the api with the URL http://localhost:3000/api
