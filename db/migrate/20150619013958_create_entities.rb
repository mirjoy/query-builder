class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
