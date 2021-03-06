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

ActiveRecord::Schema.define(version: 20170131001705) do

  create_table "api_keys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "key",                      collation: "utf8_unicode_ci"
    t.string   "app_name",                 collation: "utf8_unicode_ci"
    t.integer  "user_id"
    t.string   "github_link",              collation: "utf8_unicode_ci"
    t.index ["user_id"], name: "index_api_keys_on_user_id", using: :btree
  end

  create_table "api_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "code",                    collation: "utf8_unicode_ci"
    t.integer  "api_key_id"
    t.integer  "user_id"
    t.string   "token",                   collation: "utf8_unicode_ci"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expiry"
    t.index ["api_key_id"], name: "index_api_tokens_on_api_key_id", using: :btree
    t.index ["user_id"], name: "index_api_tokens_on_user_id", using: :btree
  end

  create_table "audits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes", limit: 65535
    t.integer  "version",                       default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index", length: { associated_type: 191 }, using: :btree
    t.index ["auditable_id", "auditable_type"], name: "auditable_index", length: { auditable_type: 191 }, using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", length: { request_uuid: 191 }, using: :btree
    t.index ["user_id", "user_type"], name: "user_index", length: { user_type: 191 }, using: :btree
  end

  create_table "blacklisted_websites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "host",                                   collation: "utf8_unicode_ci"
    t.boolean  "is_active",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "commit_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "commit_sha",                  collation: "utf8_unicode_ci"
    t.string   "status",                      collation: "utf8_unicode_ci"
    t.string   "commit_message",              collation: "utf8_unicode_ci"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "ci_url",                      collation: "utf8_unicode_ci"
  end

  create_table "deletion_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "post_id"
    t.boolean  "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "post_id_ix", using: :btree
  end

  create_table "feedbacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "message_link",                   collation: "utf8_unicode_ci"
    t.string   "user_name",                      collation: "utf8_unicode_ci"
    t.string   "user_link",                      collation: "utf8_unicode_ci"
    t.string   "feedback_type",                  collation: "utf8_unicode_ci"
    t.integer  "post_id"
    t.string   "post_link",                      collation: "utf8_unicode_ci"
    t.integer  "user_id"
    t.boolean  "is_invalidated", default: false
    t.integer  "invalidated_by"
    t.datetime "invalidated_at"
    t.integer  "chat_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_ignored",     default: false
    t.integer  "api_key_id"
    t.string   "chat_host",                      collation: "utf8_unicode_ci"
    t.index ["post_id"], name: "index_feedbacks_on_post_id", using: :btree
    t.index ["user_name"], name: "by_user_name", length: { user_name: 5 }, using: :btree
  end

  create_table "flag_conditions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.boolean  "flags_enabled",    default: true
    t.integer  "min_weight"
    t.integer  "max_poster_rep"
    t.integer  "min_reason_count"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["user_id"], name: "index_flag_conditions_on_user_id", using: :btree
  end

  create_table "flag_conditions_sites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer "flag_condition_id"
    t.integer "site_id"
  end

  create_table "flag_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.boolean  "success"
    t.string   "error_message"
    t.integer  "flag_condition_id"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.boolean  "is_dry_run"
    t.integer  "backoff"
    t.integer  "site_id"
    t.index ["created_at"], name: "index_flag_logs_on_created_at", using: :btree
    t.index ["flag_condition_id"], name: "index_flag_logs_on_flag_condition_id", using: :btree
    t.index ["post_id"], name: "index_flag_logs_on_post_id", using: :btree
    t.index ["site_id"], name: "index_flag_logs_on_site_id", using: :btree
    t.index ["user_id"], name: "index_flag_logs_on_user_id", using: :btree
  end

  create_table "flag_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "reason",                                    collation: "utf8_unicode_ci"
    t.string   "user_id",                                   collation: "utf8_unicode_ci"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_completed", default: false
    t.integer  "post_id"
    t.index ["post_id"], name: "index_flags_on_post_id", using: :btree
  end

  create_table "github_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "token"
    t.datetime "expires"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ignored_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "user_name",               collation: "utf8_unicode_ci"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "is_ignored"
    t.index ["user_id"], name: "index_ignored_users_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "title"
    t.text     "body",                   limit: 16777215
    t.string   "link"
    t.datetime "post_creation_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.string   "user_link"
    t.string   "username"
    t.text     "why",                    limit: 16777215
    t.integer  "user_reputation"
    t.integer  "score"
    t.integer  "upvote_count"
    t.integer  "downvote_count"
    t.integer  "stack_exchange_user_id"
    t.boolean  "is_tp",                                   default: false
    t.boolean  "is_fp",                                   default: false
    t.boolean  "is_naa",                                  default: false
    t.integer  "revision_count"
    t.index ["created_at"], name: "index_posts_on_created_at", using: :btree
    t.index ["link"], name: "index_posts_on_link", length: { link: 191 }, using: :btree
  end

  create_table "posts_reasons", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "reason_id"
    t.integer "post_id"
    t.index ["post_id"], name: "index_posts_reasons_on_post_id", using: :btree
    t.index ["reason_id"], name: "index_posts_reasons_on_reason_id", using: :btree
  end

  create_table "reasons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string  "reason_name",                     collation: "utf8_unicode_ci"
    t.string  "last_post_title",                 collation: "utf8_unicode_ci"
    t.boolean "inactive",        default: false
    t.integer "weight",          default: 0
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", length: { name: 191, resource_type: 191 }, using: :btree
    t.index ["name"], name: "index_roles_on_name", length: { name: 191 }, using: :btree
  end

  create_table "sites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "site_name",                                       collation: "utf8_unicode_ci"
    t.string   "site_url",                                        collation: "utf8_unicode_ci"
    t.string   "site_logo",                                       collation: "utf8_unicode_ci"
    t.string   "site_domain",                                     collation: "utf8_unicode_ci"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "flags_enabled",      default: false
    t.integer  "max_flags_per_post", default: 1
    t.boolean  "is_child_meta"
  end

  create_table "sites_user_site_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer "site_id"
    t.integer "user_site_setting_id"
  end

  create_table "smoke_detectors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.datetime "last_ping"
    t.string   "name"
    t.string   "location"
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "email_date"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_smoke_detectors_on_user_id", using: :btree
  end

  create_table "stack_exchange_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "user_id"
    t.string   "username"
    t.datetime "last_api_update"
    t.boolean  "still_alive",     default: true
    t.integer  "answer_count"
    t.integer  "question_count"
    t.integer  "reputation"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "site_id"
  end

  create_table "statistics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "posts_scanned"
    t.integer  "smoke_detector_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "api_quota"
    t.float    "post_scan_rate",    limit: 24
  end

  create_table "user_site_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "max_flags"
    t.integer  "flags_used", default: 0
    t.integer  "user_id"
    t.integer  "site_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["site_id"], name: "index_user_site_settings_on_site_id", using: :btree
    t.index ["user_id"], name: "index_user_site_settings_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "email",                      default: "",    null: false, collation: "utf8_unicode_ci"
    t.string   "encrypted_password",         default: "",    null: false, collation: "utf8_unicode_ci"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token",                                    collation: "utf8_unicode_ci"
    t.datetime "reset_password_sent_at"
    t.string   "username",                                                collation: "utf8_unicode_ci"
    t.integer  "stackexchange_chat_id"
    t.integer  "meta_stackexchange_chat_id"
    t.integer  "stackoverflow_chat_id"
    t.integer  "stack_exchange_account_id"
    t.string   "api_token"
    t.boolean  "flags_enabled",              default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "api_keys", "users"
  add_foreign_key "api_tokens", "api_keys"
  add_foreign_key "api_tokens", "users"
  add_foreign_key "flag_conditions", "users"
  add_foreign_key "flag_logs", "flag_conditions"
  add_foreign_key "flag_logs", "posts"
  add_foreign_key "flag_logs", "sites"
  add_foreign_key "flag_logs", "users"
  add_foreign_key "flags", "posts"
  add_foreign_key "ignored_users", "users"
  add_foreign_key "smoke_detectors", "users"
  add_foreign_key "user_site_settings", "sites"
  add_foreign_key "user_site_settings", "users"
end
