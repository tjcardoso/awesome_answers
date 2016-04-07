class AddViewCountToQuestion < ActiveRecord::Migration
  def change
    # you can find more info on method in here:
    # http://edgeguides.rubyonrails.org/active_record_migrations.html
    # this migration adds acolumn named 'view_count' to the "questions" table
    # the type of clumn is integer
    add_column :questions, :view_count, :integer#, default: 0, null: false
  end
end
