class AddCurrentUserToStory < ActiveRecord::Migration
  def change
    add_column :stories, :current_user, :string
  end
end
