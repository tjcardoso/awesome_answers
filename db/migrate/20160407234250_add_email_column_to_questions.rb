class AddEmailColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :email, :string
  end
end
