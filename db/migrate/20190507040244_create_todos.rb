class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :name
      t.boolean :done
      t.belongs_to :project
      t.timestamps
    end
  end
end
