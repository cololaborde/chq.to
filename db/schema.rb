ActiveRecord::Schema[7.1].define(version: 2023_11_23_224744) do
  create_table "link_accesses", force: :cascade do |t|
    t.integer "link_id", null: false
    t.datetime "accessed_at"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_link_accesses_on_link_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "slug", null: false
    t.string "destination_url", null: false
    t.string "name"
    t.integer "user_id", null: false
    t.string "type", null: false
    t.datetime "expiration_date"
    t.string "password"
    t.boolean "used"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_links_on_slug", unique: true
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.string "user_name", default: "", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "link_accesses", "links"
  add_foreign_key "links", "users"
end
