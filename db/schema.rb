ActiveRecord::Schema.define(version: 2021_03_21_071549) do

  enable_extension "plpgsql"

  create_table "label_relations", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_label_relations_on_label_id"
    t.index ["task_id"], name: "index_label_relations_on_task_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expired_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "status", default: 0, null: false
    t.integer "priority", null: false
    t.bigint "user_id"
    t.index ["name"], name: "index_tasks_on_name"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "label_relations", "labels"
  add_foreign_key "label_relations", "tasks"
  add_foreign_key "tasks", "users"
end
