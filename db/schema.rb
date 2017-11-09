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

ActiveRecord::Schema.define(version: 20171031174714) do

  create_table "advertisements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "spot_id",            null: false
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "app_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "service_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "apps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "key_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_id"
    t.string   "rut"
    t.string   "business_name"
    t.string   "line_of_business"
    t.string   "email"
    t.string   "fax"
    t.string   "address"
    t.string   "phone"
    t.string   "contact_name"
    t.integer  "city_id",          default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card_code",                    null: false
    t.string   "number",                       null: false
    t.string   "complement"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "category_id"
    t.string   "name",                                         null: false
    t.integer  "hits",                             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "filtrable_features"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "main_features"
    t.text     "html_content",       limit: 65535
    t.index ["slug"], name: "index_categories_on_slug", unique: true, using: :btree
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities_couriers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "courier_id"
    t.integer  "city_id"
    t.string   "code"
    t.boolean  "is_active",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "cities_couriers_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "city_courier_id"
    t.integer  "courier_service_id"
    t.integer  "transit_days"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "weight_limit"
    t.boolean  "is_active",          default: false, null: false
  end

  create_table "cities_couriers_services_fees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "city_courier_service_id"
    t.float    "range_min",               limit: 53
    t.float    "range_max",               limit: 53
    t.integer  "price"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "combo_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "combo_id",      null: false
    t.integer  "product_id",    null: false
    t.integer  "quantity",      null: false
    t.boolean  "show_on_list"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "is_main_combo"
    t.index ["combo_id"], name: "index_combo_products_on_combo_id", using: :btree
    t.index ["product_id"], name: "index_combo_products_on_product_id", using: :btree
  end

  create_table "combos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                 null: false
    t.string   "alias"
    t.float    "discount",   limit: 24
    t.datetime "start_date"
    t.datetime "due_date"
    t.boolean  "is_active"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "slug"
    t.index ["slug"], name: "index_combos_on_slug", unique: true, using: :btree
  end

  create_table "coupons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                       null: false
    t.string   "code",                       null: false
    t.integer  "amount"
    t.integer  "percent"
    t.date     "expires_on",                 null: false
    t.datetime "used_on"
    t.boolean  "is_massive", default: false, null: false
    t.integer  "min_amount", default: 0,     null: false
    t.boolean  "is_active",  default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courier_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.boolean  "is_active",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "couriers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key_name"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rut"
    t.boolean  "is_subscribed",          default: false
    t.boolean  "is_synchronized",        default: false, null: false
    t.boolean  "is_sent",                default: false, null: false
    t.integer  "distributor_type"
    t.boolean  "is_registered",          default: true,  null: false
    t.boolean  "is_admin",               default: false, null: false
    t.boolean  "config_search_faq",      default: true,  null: false
    t.index ["email"], name: "index_customers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "example_models", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name", limit: 30,                                      null: false
    t.string   "las_name",   limit: 30,                                      null: false
    t.string   "email",      limit: 50
    t.datetime "reg_date",              default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "faq_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_active",  default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "faqs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "content",         limit: 65535
    t.integer  "hits",                          default: 0,     null: false
    t.float    "rating",          limit: 24
    t.integer  "num_votes"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                     default: false, null: false
    t.integer  "created_by"
    t.integer  "position",                      default: 0,     null: false
    t.integer  "faq_category_id"
    t.index ["slug"], name: "index_faqs_on_slug", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "gift_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "gift_id",    null: false
    t.integer "product_id", null: false
    t.string  "message"
  end

  create_table "gifts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "message",    null: false
    t.string   "alias"
    t.string   "code"
    t.datetime "start_date"
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["customer_id"], name: "index_identities_on_customer_id", using: :btree
  end

  create_table "landing_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "landing_id", null: false
    t.string   "product_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "landings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                                         null: false
    t.string   "key_name",                                      null: false
    t.boolean  "is_active",                      default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.text     "html_header",      limit: 65535
    t.text     "html_footer",      limit: 65535
    t.string   "image_header"
    t.string   "image_footer"
    t.string   "image_background"
  end

  create_table "mailing_subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                      null: false
    t.string   "token",                      null: false
    t.boolean  "is_active",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id",                   null: false
    t.integer  "cash_offer",                   null: false
    t.boolean  "is_active",    default: true,  null: false
    t.boolean  "is_mandatory", default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "due_date"
    t.boolean  "is_flash"
    t.datetime "start_date"
    t.boolean  "show_clock"
  end

  create_table "pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "section"
    t.string   "uri"
    t.string   "external_url"
    t.string   "title"
    t.text     "content",      limit: 65535
    t.boolean  "is_active",                  default: false, null: false
    t.boolean  "is_private",                 default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_khipus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "payment_id"
    t.string   "payment_url"
    t.string   "simplified_transfer_url"
    t.string   "transfer_url"
    t.string   "app_url"
    t.string   "ready_for_terminal"
    t.string   "subject"
    t.string   "amount"
    t.string   "currency"
    t.string   "status"
    t.string   "status_detail"
    t.string   "body"
    t.string   "picture_url"
    t.string   "receipt_url"
    t.string   "return_url"
    t.string   "cancel_url"
    t.string   "notify_url"
    t.string   "notify_api_version"
    t.string   "expires_date"
    t.string   "attachment_urls"
    t.string   "bank"
    t.string   "bank_id"
    t.string   "payer_name"
    t.string   "payer_email"
    t.string   "personal_identifier"
    t.string   "bank_account_number"
    t.string   "out_of_date_conciliation"
    t.string   "transaction_id"
    t.string   "custom"
    t.string   "responsible_user_email"
    t.string   "send_reminders"
    t.string   "send_email"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "payment_webpays", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "accountingdate"
    t.string   "buyorder"
    t.string   "cardnumber"
    t.integer  "amount"
    t.string   "commercecode"
    t.string   "authorizationcode"
    t.string   "paymenttypecode"
    t.string   "responsecode"
    t.string   "transactiondate"
    t.string   "vci"
    t.string   "error_desc"
    t.string   "token_ws"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "doc_entry"
    t.integer  "doc_num"
  end

  create_table "product_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_question_id"
    t.text     "content",             limit: 65535
    t.integer  "customer_id"
    t.integer  "reviewed_by"
    t.integer  "status",                            default: 0
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "product_compatibilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "product1_id", null: false
    t.string   "product2_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product1_id"], name: "index_product_compatibilities_on_product1_id", using: :btree
    t.index ["product2_id"], name: "index_product_compatibilities_on_product2_id", using: :btree
  end

  create_table "product_features", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "product_id",                                          null: false
    t.integer  "feature_category_id",                                 null: false
    t.text     "feature_category_name", limit: 65535,                 null: false
    t.integer  "feature_id",                                          null: false
    t.text     "feature_name",          limit: 65535,                 null: false
    t.text     "value",                 limit: 65535
    t.boolean  "is_manual",                           default: false, null: false
    t.boolean  "is_active",                           default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id", "feature_id"], name: "index_product_features_on_product_id_and_feature_id", unique: true, using: :btree
    t.index ["product_id"], name: "index_product_features_on_product_id", using: :btree
  end

  create_table "product_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "product_id",                        null: false
    t.string   "path_normal",                       null: false
    t.string   "path_large"
    t.string   "path_thumb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "is_active",          default: true, null: false
  end

  create_table "product_main_features", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "product_id",                                          null: false
    t.integer  "feature_category_id",                                 null: false
    t.text     "feature_category_name", limit: 65535,                 null: false
    t.integer  "feature_id",                                          null: false
    t.text     "feature_name",          limit: 65535,                 null: false
    t.text     "value",                 limit: 65535
    t.boolean  "is_manual",                           default: false, null: false
    t.boolean  "is_active",                           default: true,  null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["product_id", "feature_id"], name: "index_product_main_features_on_product_id_and_feature_id", unique: true, using: :btree
    t.index ["product_id"], name: "index_product_main_features_on_product_id", using: :btree
  end

  create_table "product_modules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",      default: " ", null: false
    t.string   "key_name",                 null: false
    t.string   "query",                    null: false
    t.string   "spot_id",                  null: false
    t.string   "link"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "limit"
  end

  create_table "product_questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id"
    t.text     "content",     limit: 65535
    t.integer  "customer_id"
    t.integer  "reviewed_by"
    t.integer  "status",                    default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "puntuation",                default: 0
  end

  create_table "product_similarities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "product1_id", null: false
    t.string   "product2_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product1_id"], name: "index_product_similarities_on_product1_id", using: :btree
    t.index ["product2_id"], name: "index_product_similarities_on_product2_id", using: :btree
  end

  create_table "product_supplier_problems", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_supplier_id", null: false
    t.string   "reason",              null: false
    t.string   "current_part_number"
    t.string   "new_part_number"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "product_varieties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "product_id"
    t.string   "variety_id"
    t.string   "property"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_varieties_on_product_id", using: :btree
    t.index ["variety_id"], name: "index_product_varieties_on_variety_id", using: :btree
  end

  create_table "products", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                                null: false
    t.string   "part_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "brand"
    t.boolean  "is_active",                           default: false, null: false
    t.boolean  "is_highlight",                        default: false, null: false
    t.string   "icecat_code"
    t.float    "rating",                limit: 24
    t.integer  "num_reviews"
    t.text     "description",           limit: 65535
    t.string   "slug"
    t.boolean  "is_crawleable",                       default: true,  null: false
    t.float    "weight",                limit: 53,    default: 0.0,   null: false
    t.integer  "width"
    t.integer  "height"
    t.integer  "length"
    t.float    "supplier_cost_percent", limit: 24,    default: 10.0,  null: false
    t.string   "bar_code"
    t.string   "code",                                default: "",    null: false
    t.integer  "price_local",                         default: 0
    t.integer  "stock_local",                         default: 0
    t.datetime "updated_local"
    t.integer  "ref_price_local",                     default: 0
    t.boolean  "is_flash_offer_local",                default: false, null: false
    t.integer  "price_external",                      default: 0
    t.integer  "stock_external",                      default: 0
    t.datetime "updated_external"
    t.integer  "ref_price_external",                  default: 0
    t.boolean  "has_free_shipping"
    t.boolean  "has_gift"
    t.boolean  "is_digital"
    t.string   "img_thumb"
    t.string   "img_normal"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["id"], name: "index_products_on_id", unique: true, using: :btree
    t.index ["slug"], name: "index_products_on_slug", unique: true, using: :btree
  end

  create_table "products_suppliers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id",                  null: false
    t.integer  "supplier_id",                 null: false
    t.string   "code",                        null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "price",       default: 0,     null: false
    t.integer  "stock",       default: 0,     null: false
    t.string   "currency",    default: "USD", null: false
    t.boolean  "is_active",   default: false, null: false
    t.index ["product_id", "supplier_id", "code"], name: "index_products_suppliers_on_product_id_and_supplier_id_and_code", unique: true, using: :btree
  end

  create_table "query_modules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                     null: false
    t.string   "key_name",                  null: false
    t.text     "query",       limit: 65535, null: false
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id",                 null: false
    t.string   "md5",                        null: false
    t.text     "content",      limit: 65535
    t.datetime "crawled_date",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.boolean  "is_active",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "session_id",               null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "shipping_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_id",                     null: false
    t.string   "address",                         null: false
    t.string   "phone"
    t.string   "contact_name"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_synchronized", default: false, null: false
    t.integer  "city_id",         default: 1,     null: false
    t.string   "number",                          null: false
    t.string   "complement"
  end

  create_table "shopping_cart_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "shopping_cart_id"
    t.integer  "user_id"
    t.integer  "template_id"
    t.string   "bcc"
    t.string   "tags"
    t.text     "message",          limit: 65535
    t.string   "email_to"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "shopping_cart_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "shopping_cart_id",                 null: false
    t.string   "product_id",                       null: false
    t.integer  "quantity",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hardcoded_price"
    t.integer  "combo_id"
    t.boolean  "is_main_combo"
    t.integer  "price_after_discount"
    t.integer  "product_availability"
  end

  create_table "shopping_carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shipping_method",                                default: "pickup",       null: false
    t.integer  "shipping_address_id"
    t.string   "payment_method",                                 default: "transference", null: false
    t.string   "payment_receipt",                                default: "ticket",       null: false
    t.text     "shipping_address_address",         limit: 65535
    t.string   "shipping_address_city"
    t.string   "shipping_address_phone"
    t.string   "shipping_service"
    t.text     "discount_code",                    limit: 65535
    t.string   "is_anonymous",                                   default: "U",            null: false
    t.boolean  "is_synchronized",                                default: false,          null: false
    t.integer  "doc_num"
    t.integer  "hardcoded_total_amount",                         default: 0
    t.datetime "checkout_date"
    t.string   "shipping_address_contact_name"
    t.boolean  "is_sent",                                        default: false,          null: false
    t.string   "token"
    t.integer  "shipping_cost"
    t.integer  "billing_address_id"
    t.string   "billing_address_rut"
    t.string   "billing_address_business_name"
    t.string   "billing_address_line_of_business"
    t.string   "billing_address_email"
    t.string   "billing_address_fax"
    t.string   "billing_address_address"
    t.string   "billing_address_phone"
    t.string   "billing_address_contact_name"
    t.integer  "billing_address_city"
    t.string   "billing_address_card_code"
    t.integer  "doc_entry"
    t.integer  "status_id",                                      default: 1,              null: false
    t.string   "shipping_withdrawer_name"
    t.string   "delivery_time"
    t.integer  "discount_amount_combo"
    t.integer  "discount_amount_coupon"
    t.float    "discount_percent_coupon",          limit: 24
    t.string   "shipping_address_complement"
    t.string   "shipping_address_number"
    t.string   "billing_address_number"
    t.datetime "paid_date"
    t.string   "card_code"
    t.string   "tracking_number"
    t.string   "tracking_state"
    t.string   "tracking_service"
    t.text     "tracking_log",                     limit: 65535
    t.string   "tracking_extra"
  end

  create_table "simple_captcha_data", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["key"], name: "idx_key", using: :btree
  end

  create_table "statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key_name",   null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stock_subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id",                null: false
    t.string   "email",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",  default: true, null: false
  end

  create_table "suppliers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key_name"
    t.string   "name"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "is_active",                 default: false, null: false
    t.float    "margin_percent", limit: 53, default: 10.0,  null: false
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                       collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key_name",                  null: false
    t.string   "description"
    t.text     "content",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_data", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "rut",          null: false
    t.string   "contact_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "customer_id",  null: false
  end

  create_table "varieties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "key_name"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "viewed_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "product_id",              null: false
    t.integer  "customer_id",             null: false
    t.integer  "hits",        default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vouchers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "shopping_cart_id",                         null: false
    t.string   "amount",                                   null: false
    t.string   "destination_account",                      null: false
    t.date     "deposit_date",                             null: false
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.boolean  "is_synchronized",      default: false,     null: false
    t.boolean  "is_sent",              default: false,     null: false
    t.string   "status",               default: "pending", null: false
    t.integer  "doc_entry"
    t.integer  "doc_num"
  end

  create_table "wish_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id", "customer_id"], name: "index_wish_lists_on_product_id_and_customer_id", unique: true, using: :btree
  end

end
