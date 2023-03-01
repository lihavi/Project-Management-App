class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    crete_table :projects do |t|
      t.integer :project_id
      t.string :name
      t.string :description
      t.integer :owner_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
