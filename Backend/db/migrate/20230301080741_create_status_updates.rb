class CreateStatusUpdates < ActiveRecord::Migration[6.1]
  def change
    create_table :status_updates do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :user_id
      t.string  :status
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
