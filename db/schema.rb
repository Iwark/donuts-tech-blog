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

ActiveRecord::Schema.define(version: 20150903060257) do

  create_table "article_images", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "article_id", limit: 4
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "article_images", ["article_id"], name: "index_article_images_on_article_id", using: :btree
  add_index "article_images", ["user_id"], name: "index_article_images_on_user_id", using: :btree

  create_table "article_tags", force: :cascade do |t|
    t.integer  "article_id", limit: 4, null: false
    t.integer  "tag_id",     limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "article_tags", ["article_id"], name: "index_article_tags_on_article_id", using: :btree
  add_index "article_tags", ["tag_id"], name: "index_article_tags_on_tag_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "title",       limit: 255
    t.text     "body",        limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "status",      limit: 4,     default: 0
    t.integer  "series_id",   limit: 4
    t.datetime "approved_at"
  end

  add_index "articles", ["approved_at"], name: "index_articles_on_approved_at", using: :btree
  add_index "articles", ["series_id"], name: "index_articles_on_series_id", using: :btree
  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "series", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "parent_id",      limit: 4
    t.integer  "lft",            limit: 4,               null: false
    t.integer  "rgt",            limit: 4,               null: false
    t.integer  "depth",          limit: 4,   default: 0, null: false
    t.integer  "children_count", limit: 4,   default: 0, null: false
    t.integer  "articles_count", limit: 4,   default: 0, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "tags", ["lft"], name: "index_tags_on_lft", using: :btree
  add_index "tags", ["parent_id"], name: "index_tags_on_parent_id", using: :btree
  add_index "tags", ["rgt"], name: "index_tags_on_rgt", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",              limit: 255, default: "", null: false
    t.string   "encrypted_password", limit: 255, default: "", null: false
    t.integer  "sign_in_count",      limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip", limit: 255
    t.string   "last_sign_in_ip",    limit: 255
    t.string   "name",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authority",          limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "article_images", "articles"
  add_foreign_key "article_images", "users"
  add_foreign_key "article_tags", "articles"
  add_foreign_key "article_tags", "tags"
  add_foreign_key "articles", "series"
  add_foreign_key "articles", "users"
end
