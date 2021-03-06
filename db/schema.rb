# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_24_090042) do

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "application_accepteds", force: :cascade do |t|
    t.integer "candidate_id", null: false
    t.integer "job_offer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_application_accepteds_on_candidate_id"
    t.index ["job_offer_id"], name: "index_application_accepteds_on_job_offer_id"
  end

  create_table "candidate_addresses", force: :cascade do |t|
    t.integer "curriculum_id", null: false
    t.string "country"
    t.string "cep"
    t.string "state"
    t.string "city"
    t.string "hood"
    t.string "street"
    t.string "cel"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["curriculum_id"], name: "index_candidate_addresses_on_curriculum_id"
  end

  create_table "candidate_job_applications", force: :cascade do |t|
    t.integer "candidate_id", null: false
    t.integer "job_offer_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_candidate_job_applications_on_candidate_id"
    t.index ["job_offer_id"], name: "index_candidate_job_applications_on_job_offer_id"
  end

  create_table "candidate_personals", force: :cascade do |t|
    t.integer "curriculum_id", null: false
    t.string "children"
    t.string "married"
    t.string "cpf"
    t.string "race"
    t.string "nationality"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["curriculum_id"], name: "index_candidate_personals_on_curriculum_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_url"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "header"
    t.string "image_url"
  end

  create_table "company_addresses", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "country"
    t.string "cep"
    t.string "state"
    t.string "city"
    t.string "hood"
    t.string "street"
    t.string "cel"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_addresses_on_company_id"
  end

  create_table "company_personals", force: :cascade do |t|
    t.string "cnpj"
    t.string "size"
    t.string "aboutUs"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_personals_on_company_id"
  end

  create_table "curriculums", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "about_me"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_curriculums_on_user_id"
  end

  create_table "interviews", force: :cascade do |t|
    t.integer "candidate_id", null: false
    t.integer "company_id", null: false
    t.integer "job_offer_id", null: false
    t.string "status"
    t.string "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_interviews_on_candidate_id"
    t.index ["company_id"], name: "index_interviews_on_company_id"
    t.index ["job_offer_id"], name: "index_interviews_on_job_offer_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "image"
    t.string "video"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "job_offers", force: :cascade do |t|
    t.string "requirement"
    t.integer "user_id", null: false
    t.string "salary"
    t.string "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_job_offers_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "curriculum_id", null: false
    t.string "start"
    t.string "end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["curriculum_id"], name: "index_jobs_on_curriculum_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "profile_type"
    t.integer "profile_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "application_accepteds", "candidates"
  add_foreign_key "application_accepteds", "job_offers"
  add_foreign_key "candidate_addresses", "curriculums"
  add_foreign_key "candidate_job_applications", "candidates"
  add_foreign_key "candidate_job_applications", "job_offers"
  add_foreign_key "candidate_personals", "curriculums"
  add_foreign_key "company_addresses", "companies"
  add_foreign_key "company_personals", "companies"
  add_foreign_key "curriculums", "users"
  add_foreign_key "interviews", "candidates"
  add_foreign_key "interviews", "companies"
  add_foreign_key "interviews", "job_offers"
  add_foreign_key "job_offers", "users"
  add_foreign_key "jobs", "curriculums"
end
