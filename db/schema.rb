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

ActiveRecord::Schema[7.1].define(version: 2024_11_01_010738) do
  create_table "agendamentos", force: :cascade do |t|
    t.integer "cliente_id"
    t.integer "consultor_id"
    t.date "data"
    t.time "hora_inicio"
    t.time "hora_fim"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "disponibilidade_id"
    t.index ["cliente_id"], name: "index_agendamentos_on_cliente_id"
    t.index ["consultor_id"], name: "index_agendamentos_on_consultor_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "nome"
    t.string "descricao"
    t.string "icone"
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
    t.string "nome"
    t.string "descricao"
    t.integer "area_id", null: false
    t.string "icone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_especialidades_on_area_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "consultor"
    t.integer "especialidade_id"
    t.integer "cidade_id"
    t.string "nome"
    t.text "descricao"
    t.string "foto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "agendamentos", "disponibilidade_consultors", column: "disponibilidade_id"
  add_foreign_key "agendamentos", "users", column: "cliente_id"
  add_foreign_key "agendamentos", "users", column: "consultor_id"
  add_foreign_key "disponibilidade_consultors", "users", column: "consultor_id"
  add_foreign_key "especialidades", "areas"
end
