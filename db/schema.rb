# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_22_200948) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "status_list", ["pending", "cancelled", "delivered"]

  create_table "items", force: :cascade do |t|
    t.string "description", default: "", null: false
    t.string "reference", default: "", null: false
    t.decimal "price", default: "0.0", null: false
    t.decimal "actual_quantity", default: "0.0", null: false
    t.decimal "expected_quantity", default: "0.0", null: false
    t.bigint "supplier_id", null: false
    t.bigint "space_id", null: false
    t.string "unit", default: "unit", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_items_on_space_id"
    t.index ["supplier_id"], name: "index_items_on_supplier_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "sku", null: false
    t.bigint "space_id", null: false
    t.bigint "owner_id", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_links_on_owner_id"
    t.index ["sku"], name: "index_links_on_sku", unique: true
    t.index ["space_id", "owner_id"], name: "index_links_on_space_id_and_owner_id", unique: true
    t.index ["space_id"], name: "index_links_on_space_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "item_id", null: false
    t.decimal "quantity", default: "1.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "space_id", null: false
    t.bigint "supplier_id", null: false
    t.datetime "expected_at"
    t.datetime "delivered_at"
    t.enum "status", default: "pending", null: false, enum_type: "status_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_orders_on_space_id"
    t.index ["supplier_id"], name: "index_orders_on_supplier_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "body", default: "", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "product_items", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "item_id", null: false
    t.decimal "gross_quantity", default: "1.0", null: false
    t.decimal "net_quantity", default: "1.0", null: false
    t.decimal "quantity_ratio", default: "1.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_product_items_on_item_id"
    t.index ["product_id"], name: "index_product_items_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "description", default: "", null: false
    t.decimal "price", default: "0.0", null: false
    t.bigint "space_id", null: false
    t.integer "sales_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_products_on_space_id"
  end

  create_table "space_users", force: :cascade do |t|
    t.bigint "space_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id", "user_id"], name: "index_space_users_on_space_id_and_user_id", unique: true
    t.index ["space_id"], name: "index_space_users_on_space_id"
    t.index ["user_id"], name: "index_space_users_on_user_id"
  end

  create_table "spaces", force: :cascade do |t|
    t.string "description", null: false
    t.string "software", default: "none", null: false
    t.bigint "owner_id", null: false
    t.boolean "public", default: false, null: false
    t.string "extra_units", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_spaces_on_owner_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "space_id", null: false
    t.integer "expected_day", default: 0, null: false
    t.integer "expected_week", default: 0, null: false
    t.integer "expected_month", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_suppliers_on_space_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.boolean "confirmed", default: true, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "spaces"
  add_foreign_key "items", "suppliers"
  add_foreign_key "links", "spaces"
  add_foreign_key "links", "users", column: "owner_id"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "spaces"
  add_foreign_key "orders", "suppliers"
  add_foreign_key "posts", "users"
  add_foreign_key "product_items", "items"
  add_foreign_key "product_items", "products"
  add_foreign_key "products", "spaces"
  add_foreign_key "space_users", "spaces"
  add_foreign_key "space_users", "users"
  add_foreign_key "spaces", "users", column: "owner_id"
  add_foreign_key "suppliers", "spaces"
end
