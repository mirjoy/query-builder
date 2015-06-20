class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.string :excerpt
      t.string :keywords
      t.string :entity
      t.string :sentiment
      t.string :taxonomy

      t.timestamps null: false
    end
  end
end
