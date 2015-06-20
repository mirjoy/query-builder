class AddFieldsToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :entity_type, :string
    add_column :entities, :sentiment, :string
    add_column :entities, :story_id, :integer
  end
end
