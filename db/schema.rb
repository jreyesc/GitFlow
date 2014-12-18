# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141211195300) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], :name => "index_admins_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  end

  create_table "esa_types", force: true do |t|
    t.string   "name"
    t.integer  "esa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["esa_id"], :name => "fk__esa_types_esa_id"
  end

  create_table "esas", force: true do |t|
    t.string   "title"
    t.text     "first_section_msj"
    t.text     "second_section_msj"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "main_image_file_name"
    t.string   "main_image_content_type"
    t.integer  "main_image_file_size"
    t.datetime "main_image_updated_at"
    t.string   "first_section_img_file_name"
    t.string   "first_section_img_content_type"
    t.integer  "first_section_img_file_size"
    t.datetime "first_section_img_updated_at"
    t.string   "second_section_img_file_name"
    t.string   "second_section_img_content_type"
    t.integer  "second_section_img_file_size"
    t.datetime "second_section_img_updated_at"
    t.string   "esa_type"
    t.boolean  "flag_show"
    t.text     "congratulations_message"
    t.integer  "esa_type_id"
    t.string   "petition_link"
    t.integer  "row_order"
    t.string   "areas_message"
    t.index ["esa_type_id"], :name => "fk__esas_esa_type_id"
    t.foreign_key ["esa_type_id"], "esa_types", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_esas_esa_type_id"
  end

  add_foreign_key "esa_types", ["esa_id"], "esas", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_esa_types_esa_id"

  create_table "areas", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "esa_id"
    t.string   "icon_image_file_name"
    t.string   "icon_image_content_type"
    t.integer  "icon_image_file_size"
    t.datetime "icon_image_updated_at"
    t.boolean  "reachability"
    t.integer  "row_order"
    t.index ["esa_id"], :name => "fk__areas_esa_id"
    t.foreign_key ["esa_id"], "esas", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_areas_esa_id"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], :name => "delayed_jobs_priority"
  end

  create_table "group_items", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reachability"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "nivel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "area_id"
    t.integer  "energy_value"
    t.integer  "max_sockets"
    t.integer  "row_order"
    t.integer  "disabled_item"
    t.index ["area_id"], :name => "fk__items_area_id"
    t.index ["parent_id"], :name => "fk__items_parent_id"
    t.foreign_key ["area_id"], "areas", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_items_area_id"
    t.foreign_key ["parent_id"], "items", ["id"], :on_update => :restrict, :on_delete => :cascade, :name => "fk_items_parent_id"
  end

  create_table "items_per_groups", force: true do |t|
    t.integer  "group_item_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sockets"
    t.index ["group_item_id"], :name => "fk__items_per_groups_group_item_id"
    t.index ["item_id"], :name => "fk__items_per_groups_item_id"
    t.foreign_key ["group_item_id"], "group_items", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_items_per_groups_group_item_id"
    t.foreign_key ["item_id"], "items", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_items_per_groups_item_id"
  end

  create_table "recommendations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "area_id"
    t.integer  "energy_value"
    t.float    "total_saving",            limit: 24
    t.text     "goal_text"
    t.integer  "total_sockets"
    t.boolean  "reachability"
    t.string   "goal_image_file_name"
    t.string   "goal_image_content_type"
    t.integer  "goal_image_file_size"
    t.datetime "goal_image_updated_at"
    t.integer  "min_energy"
    t.integer  "max_energy"
    t.index ["area_id"], :name => "fk__recommendations_area_id"
    t.foreign_key ["area_id"], "areas", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_recommendations_area_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  end

  create_table "recommendation_by_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_item_id"
    t.integer  "recommendation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "area_id"
    t.string   "name"
    t.index ["area_id"], :name => "fk__recommendation_by_users_area_id"
    t.index ["group_item_id"], :name => "fk__recommendation_by_users_group_item_id"
    t.index ["recommendation_id"], :name => "fk__recommendation_by_users_recommendation_id"
    t.index ["user_id"], :name => "fk__recommendation_by_users_user_id"
    t.foreign_key ["area_id"], "areas", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_recommendation_by_users_area_id"
    t.foreign_key ["group_item_id"], "group_items", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_recommendation_by_users_group_item_id"
    t.foreign_key ["recommendation_id"], "recommendations", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_recommendation_by_users_recommendation_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_recommendation_by_users_user_id"
  end

  create_table "recommendation_items", force: true do |t|
    t.string   "comment"
    t.integer  "cost"
    t.integer  "recommendation_id"
    t.float    "save_percentage",   limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amazon_code"
    t.string   "image_url"
    t.text     "features"
    t.text     "title"
    t.text     "price"
    t.integer  "sockets"
    t.index ["recommendation_id"], :name => "fk__recommendation_items_recommendation_id"
    t.foreign_key ["recommendation_id"], "recommendations", ["id"], :on_update => :restrict, :on_delete => :cascade, :name => "fk_recommendation_items_recommendation_id"
  end

  create_table "steps", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recommendation_id"
    t.index ["recommendation_id"], :name => "fk__steps_recommendation_id"
    t.foreign_key ["recommendation_id"], "recommendations", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_steps_recommendation_id"
  end

end
