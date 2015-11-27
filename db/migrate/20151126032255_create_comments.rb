class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :description
      t.string :created_by
      t.references :ticket, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
