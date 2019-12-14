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

ActiveRecord::Schema.define(version: 2019_12_13_230132) do

  create_table "crms", primary_key: "id_crm", force: :cascade do |t|
    t.string "name", limit: 30
    t.string "mail", limit: 100
    t.string "feedback", limit: 150
  end

  create_table "users", primary_key: "id_user", force: :cascade do |t|
    t.string "login"
    t.string "password"
  end

  create_table "versions", primary_key: "id_version", force: :cascade do |t|
    t.string "version", limit: 10
    t.string "version_change", limit: 255
  end

end
