class AddDefaultValueToKeywords < ActiveRecord::Migration
  def change
    change_column :stories, :keywords, :string, :default => "No keywords found."
  end
end
