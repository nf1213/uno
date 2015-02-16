class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :number, null: false
      t.string :color

      t.timestamps null: false
    end
  end
end
