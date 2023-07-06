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

ActiveRecord::Schema[7.0].define(version: 2023_04_26_010402) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chatrooms", force: :cascade do |t|
    t.string "motivo", null: false
    t.boolean "soporte", default: false, null: false
    t.string "remitente", null: false
    t.string "creador", null: false
    t.string "estado", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comentarios", force: :cascade do |t|
    t.string "contenido"
    t.integer "calificacion"
    t.datetime "fecha"
    t.bigint "publicacion_id", null: false
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publicacion_id"], name: "index_comentarios_on_publicacion_id"
    t.index ["usuario_id"], name: "index_comentarios_on_usuario_id"
  end

  create_table "joyas", force: :cascade do |t|
    t.integer "cantidad"
    t.string "estado"
    t.datetime "fecha_compra"
    t.bigint "publicacion_id", null: false
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publicacion_id"], name: "index_joyas_on_publicacion_id"
    t.index ["usuario_id"], name: "index_joyas_on_usuario_id"
  end

  create_table "mensajes", force: :cascade do |t|
    t.string "body", null: false
    t.bigint "usuario_id", null: false
    t.bigint "chatroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_mensajes_on_chatroom_id"
    t.index ["usuario_id"], name: "index_mensajes_on_usuario_id"
  end

  create_table "publicacions", force: :cascade do |t|
    t.string "vendedor"
    t.string "nombre"
    t.string "tipo_joya"
    t.integer "precio"
    t.text "descripcion"
    t.string "color"
    t.string "imagen"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "nombre", default: "", null: false
    t.string "nombre_usuario", default: "", null: false
    t.integer "tipo_usuario", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  add_foreign_key "comentarios", "publicacions"
  add_foreign_key "comentarios", "usuarios"
  add_foreign_key "joyas", "publicacions"
  add_foreign_key "joyas", "usuarios"
  add_foreign_key "mensajes", "chatrooms"
  add_foreign_key "mensajes", "usuarios"
end
