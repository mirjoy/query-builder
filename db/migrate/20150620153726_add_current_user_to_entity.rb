class AddCurrentUserToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :current_user, :string
  end
end
