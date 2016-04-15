April 15, 2016. Awesome_answers Project:

_________________________________________

type              gem 'rails-erd'   # in gemfile  (awesome answers)
also, uncomment   gem 'bcrypt'      # in the gemfile (already in there by default, just needs to be uncommented)

______________________________________
Commands to run in the terminal:

bin/rails g model user first_name last_name email password_digest
bin/rake db:migrate

bundle install           # in awesome answers folder
brew instal graphviz     # <-- this takes a while, maybe slow internet

atom ~/.erdconfig

# paste this into the erdconfig file:

attributes:
  - content
  - foreign_key
  - inheritance

save erdconfig

rake erd

open erd.pdf  #  (to view an ERD of your project)

bin/rails g controller users
____________________________________

In atom, open up user.rb (model) and paste this:

class User < ActiveRecord::Base

  # has-secure_password does the following:
  # 1 - it adds attribute accessors: password and password_confirmation
  # 2 - it adds validation: password must be present on creation
  # 3 - if password confirmation is present, it will make sure its equal to password
  # 4 - PAssword length should be less than or equal to 72 chars
  # 5 - it will has the password using bcrypt and stores the has digest in the
  #      password digets field
  has_secure_password

  # attr_accessor :abc

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX
end

_________________________________________

(tam does a bunch of rails stuff - just fork his github)

bin/rails g controller sessions
