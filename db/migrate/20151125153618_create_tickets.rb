class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :customer_email
      t.string :customer_name
      t.string :created_by
      t.string :assigned_to
      t.string :area

      t.timestamps null: false
    end
  end
end
