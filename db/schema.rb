ActiveRecord::Schema.define(version: 20150619013958) do
  enable_extension "plpgsql"

  create_table "entities", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
