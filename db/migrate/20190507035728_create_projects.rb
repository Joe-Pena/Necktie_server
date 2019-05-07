class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :done
      t.has_many :todos
      t.timestamps
    end
  end
end
