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

ActiveRecord::Schema[7.0].define(version: 2025_04_23_172100) do
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

  create_table "backgrounds", force: :cascade do |t|
    t.string "name", null: false
    t.integer "game_system_id"
    t.index ["game_system_id"], name: "index_backgrounds_on_game_system_id"
  end

  create_table "backgrounds_character_stats", id: false, force: :cascade do |t|
    t.integer "background_id"
    t.integer "character_stat_id"
    t.index ["background_id"], name: "index_backgrounds_character_stats_on_background_id"
    t.index ["character_stat_id"], name: "index_backgrounds_character_stats_on_character_stat_id"
  end

  create_table "character_appearances", force: :cascade do |t|
    t.string "appearance", null: false
    t.integer "game_system_id"
    t.index ["game_system_id"], name: "index_character_appearances_on_game_system_id"
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

  create_table "character_names_name_styles", id: false, force: :cascade do |t|
    t.integer "character_name_id"
    t.integer "name_style_id"
    t.index ["character_name_id"], name: "index_character_names_name_styles_on_character_name_id"
    t.index ["name_style_id"], name: "index_character_names_name_styles_on_name_style_id"
  end

  create_table "character_stats", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbreviation", null: false
    t.integer "game_system_id"
    t.index ["game_system_id"], name: "index_character_stats_on_game_system_id"
  end

  create_table "game_systems", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "allows_multiclassing", default: true
    t.string "key"
  end

  create_table "game_systems_name_styles", id: false, force: :cascade do |t|
    t.integer "game_system_id"
    t.integer "name_style_id"
    t.index ["game_system_id"], name: "index_game_systems_name_styles_on_game_system_id"
    t.index ["name_style_id"], name: "index_game_systems_name_styles_on_name_style_id"
  end

  create_table "game_systems_player_classes", id: false, force: :cascade do |t|
    t.integer "player_class_id"
    t.integer "game_system_id"
    t.index ["game_system_id"], name: "index_game_systems_player_classes_on_game_system_id"
    t.index ["player_class_id"], name: "index_game_systems_player_classes_on_player_class_id"
  end

  create_table "game_systems_player_subclasses", id: false, force: :cascade do |t|
    t.integer "game_system_id"
    t.integer "player_subclass_id"
    t.index ["game_system_id"], name: "index_game_systems_player_subclasses_on_game_system_id"
    t.index ["player_subclass_id"], name: "index_game_systems_player_subclasses_on_player_subclass_id"
  end

  create_table "lineages", force: :cascade do |t|
    t.string "name", null: false
    t.integer "ancestry_id"
    t.integer "game_system_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry_id"], name: "index_lineages_on_ancestry_id"
    t.index ["game_system_id"], name: "index_lineages_on_game_system_id"
  end

  create_table "name_styles", force: :cascade do |t|
    t.string "style", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_classes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_modifier"
    t.boolean "name_modifier_is_prefix", default: true
    t.decimal "hit_die"
  end

  create_table "player_subclasses", force: :cascade do |t|
    t.integer "player_class_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "num_additional_classes_allowed", default: "0.0"
    t.index ["player_class_id"], name: "index_player_subclasses_on_player_class_id"
  end

  add_foreign_key "player_subclasses", "player_classes"
end
