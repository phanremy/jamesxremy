# PROJECT TEMPLATE

**PROJECT TEMPLATE** to be used with caution and as per latest gem updates
## Technical Stack

- Ruby `3.0.3`
- Ruby on Rails `7.0.3`
- [Hotwire](https://hotwired.dev/)
- gem 'cancancan' (Use Cancan for authorization)
- gem 'devise' (Use Devise for authentication)
- gem 'acts_as_votable' (Use Acts as votable for upvotes)
- gem 'pagy' (Use Pagy for paginating with infinite scrolling options)
- gem 'bullet' (Use bullet for detecting N+1 query)
- gem 'faker' (Use Faker for seeding fake info)
- gem 'rubocop-rails' (Use Rubocop Rails with yml ignoring comments)
- gem 'importmap-rails' (Use Importmap Rails to replace webpacker)
- gem 'tailwindcss-rails' (Use Tailwindcss-Rails to use Tailwind)
- javascript library 'slim-select' (Enhance multiple select)

## Install

### Pre-requisites
- Ruby `3.0.3`
- Ruby on Rails `7.0`
- PostgreSQL `>~ 13`

### Use template
```
git clone git@github.com:phanremy/cheatcheet.git
cd cheatcheet
```

### Install dependencies
```
bundle
```

### After using the template
```
rails new --database postgresql --javascript importmaps --css tailwind "APP_NAME"
rails generate devise:install
rails generate devise User
rails db:migrate
rails g model post title body:text user:references
rails g cancan:ability
./bin/bundle add importmap-rails
./bin/rails importmap:install
./bin/rails tailwindcss:install
./bin/rails turbo:install
```
modify the images/components as per this [tutorial](https://www.lewagon.com/blog/setup-meta-tags-rails)

deploy on [heroku](https://heroku.com/) or [fly.io](https://fly.io/)

### Initialize the database
```
rails db:create db:migrate db:seed
```

## Structure

### Database structure

#### Post
- title
- body
- belongs to user

#### User
- email
- password
- admin?
- confirmed?

#### Space
- description
- public?
- belongs to an owner (an user)

#### SpaceUser
- belongs to a space
- belongs to an user
- todo: add a role to user

#### Link
- sku
- end date
- belongs to a space
- belongs to an owner (an user)

### Controller structure

#### Posts
- all

#### Users
- index
- edit
- update
- destroy

#### Spaces
- all

#### Spaces::Users
- create

#### Links
- show link/:sku: valid until end date, to give access to a specific space, created by space owner
- create
- destroy

### Serve

#### If you're using [Overmind](https://github.com/DarthSim/overmind)
```
overmind s
```

#### If you're using Foreman
```
foreman start
```

#### Classique way
```
rails s
```

## Testing
- rubocop
```
rubocop
```
- [MiniTest](https://guides.rubyonrails.org/testing.html)
```
rails test
```
