# this file doesnt auto create the table, it just defines ho the table
# must be created. To execute it, you will have to run:  bin/rake db:migrate

class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      # you don't need to explicitly define the id field as it will be added
      # automatically. Rails will add an 'id' filed that is an integer primary key
      # with "autoincrement"
      t.string :title
      t.text :body

      # timestamps will add two extra fields :  created_at and updated_at
      # they will be of type: datetime
      # they will be automaatically set by Active Record
      t.timestamps null: false
    end
  end
end
