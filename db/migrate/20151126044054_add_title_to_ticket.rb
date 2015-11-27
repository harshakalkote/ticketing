class AddTitleToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :title, :string
    add_column :tickets, :issue, :string
  end
end
