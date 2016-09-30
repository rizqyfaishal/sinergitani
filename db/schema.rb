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

ActiveRecord::Schema.define(version: 20160929174648) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "districts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "regency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["regency_id"], name: "index_districts_on_regency_id", using: :btree
  end

  create_table "donasis", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.decimal  "amount",     precision: 10
    t.integer  "funding_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "donatur_id"
    t.index ["donatur_id"], name: "index_donasis_on_donatur_id", using: :btree
    t.index ["funding_id"], name: "index_donasis_on_funding_id", using: :btree
  end

  create_table "donaturs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "fundings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.decimal  "total",                          precision: 10
    t.integer  "kelompok_tani_id"
    t.date     "deadline"
    t.text     "description",      limit: 65535
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "donasi_id"
    t.index ["donasi_id"], name: "index_fundings_on_donasi_id", using: :btree
    t.index ["kelompok_tani_id"], name: "index_fundings_on_kelompok_tani_id", using: :btree
  end

  create_table "kelompok_tanis", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "group_name"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.integer  "province_id"
    t.integer  "regency_id"
    t.integer  "district_id"
    t.integer  "village_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["district_id"], name: "index_kelompok_tanis_on_district_id", using: :btree
    t.index ["province_id"], name: "index_kelompok_tanis_on_province_id", using: :btree
    t.index ["regency_id"], name: "index_kelompok_tanis_on_regency_id", using: :btree
    t.index ["village_id"], name: "index_kelompok_tanis_on_village_id", using: :btree
  end

  create_table "provinces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "province_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["province_id"], name: "index_regencies_on_province_id", using: :btree
  end

  create_table "results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "implementation"
    t.string   "result"
    t.integer  "increasing_number"
    t.integer  "kelompok_tani_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["kelompok_tani_id"], name: "index_results_on_kelompok_tani_id", using: :btree
  end

  create_table "villages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "district_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["district_id"], name: "index_villages_on_district_id", using: :btree
  end

  add_foreign_key "districts", "regencies"
  add_foreign_key "donasis", "donaturs"
  add_foreign_key "donasis", "fundings"
  add_foreign_key "fundings", "donasis"
  add_foreign_key "fundings", "kelompok_tanis"
  add_foreign_key "kelompok_tanis", "districts"
  add_foreign_key "kelompok_tanis", "provinces"
  add_foreign_key "kelompok_tanis", "regencies"
  add_foreign_key "kelompok_tanis", "villages"
  add_foreign_key "regencies", "provinces"
  add_foreign_key "results", "kelompok_tanis"
  add_foreign_key "villages", "districts"
end
