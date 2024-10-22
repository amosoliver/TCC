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

ActiveRecord::Schema[7.1].define(version: 2024_10_22_011506) do
  create_table "agendamentos", force: :cascade do |t|
    t.integer "cliente_id"
    t.integer "consultor_id"
    t.date "data"
    t.time "hora_inicio"
    t.time "hora_fim"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_agendamentos_on_cliente_id"
    t.index ["consultor_id"], name: "index_agendamentos_on_consultor_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cidades", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disponibilidade_consultors", force: :cascade do |t|
    t.integer "consultor_id"
    t.date "data"
    t.time "hora_inicio"
    t.time "hora_fim"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultor_id"], name: "index_disponibilidade_consultors_on_consultor_id"
  end

  create_table "especialidades", force: :cascade do |t|
    t.string "descricao"
    t.integer "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_especialidades_on_area_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "especialidade_id", null: false
    t.boolean "consultor"
    t.integer "cidade_id", null: false
    t.index ["cidade_id"], name: "index_users_on_cidade_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["especialidade_id"], name: "index_users_on_especialidade_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "agendamentos", "users", column: "cliente_id"
  add_foreign_key "agendamentos", "users", column: "consultor_id"
  add_foreign_key "disponibilidade_consultors", "users", column: "consultor_id"
  add_foreign_key "especialidades", "areas"
  add_foreign_key "users", "cidades"
  add_foreign_key "users", "especialidades"
end
