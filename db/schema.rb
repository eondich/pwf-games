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

ActiveRecord::Schema[7.0].define(version: 2023_11_08_032335) do
  create_table "ancestries", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ancestries_character_names", id: false, force: :cascade do |t|
    t.integer "ancestry_id"
    t.integer "character_name_id"
    t.index ["ancestry_id"], name: "index_ancestries_character_names_on_ancestry_id"
    t.index ["character_name_id"], name: "index_ancestries_character_names_on_character_name_id"
  end

  create_table "ancestries_game_systems", id: false, force: :cascade do |t|
    t.integer "ancestry_id"
    t.integer "game_system_id"
    t.index ["ancestry_id"], name: "index_ancestries_game_systems_on_ancestry_id"
    t.index ["game_system_id"], name: "index_ancestries_game_systems_on_game_system_id"
  end

  create_table "character_names", force: :cascade do |t|
    t.string "value", null: false
    t.integer "gender"
    t.integer "name_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "character_names_game_systems", id: false, force: :cascade do |t|
    t.integer "character_name_id"
    t.integer "game_system_id"
    t.index ["character_name_id"], name: "index_character_names_game_systems_on_character_name_id"
    t.index ["game_system_id"], name: "index_character_names_game_systems_on_game_system_id"
  end

  create_table "game_systems", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_systems_player_classes", id: false, force: :cascade do |t|
    t.integer "player_class_id"
    t.integer "game_system_id"
    t.index ["game_system_id"], name: "index_game_systems_player_classes_on_game_system_id"
    t.index ["player_class_id"], name: "index_game_systems_player_classes_on_player_class_id"
  end

  create_table "player_classes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_subclasses", force: :cascade do |t|
    t.integer "player_class_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_class_id"], name: "index_player_subclasses_on_player_class_id"
  end

  add_foreign_key "player_subclasses", "player_classes"
end
