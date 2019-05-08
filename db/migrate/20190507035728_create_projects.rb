class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :done
      t.integer :todos, array: true, default: []
      t.timestamps
    end
  end
end
