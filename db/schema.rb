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

ActiveRecord::Schema[7.0].define(version: 2023_10_15_021833) do
  create_table "ambassadors", force: :cascade do |t|
    t.integer "ancestry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry_id"], name: "index_ambassadors_on_ancestry_id"
  end

  create_table "ancestries", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artisans", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "character_name_ancestries", id: false, force: :cascade do |t|
    t.integer "ancestry_id"
    t.integer "given_name_id"
    t.index ["ancestry_id"], name: "index_character_name_ancestries_on_ancestry_id"
    t.index ["given_name_id"], name: "index_character_name_ancestries_on_given_name_id"
  end

  create_table "character_name_source_materials", id: false, force: :cascade do |t|
    t.integer "character_name_id"
    t.integer "source_material_id"
    t.index ["character_name_id"], name: "index_character_name_source_materials_on_character_name_id"
    t.index ["source_material_id"], name: "index_character_name_source_materials_on_source_material_id"
  end

  create_table "character_names", force: :cascade do |t|
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "name_type", null: false
    t.integer "gender"
  end

  create_table "follower_rolls", force: :cascade do |t|
    t.integer "player_class_id"
    t.decimal "min_roll", null: false
    t.decimal "max_roll", null: false
    t.string "follower_type"
    t.integer "follower_id"
    t.decimal "follower_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_type", "follower_id"], name: "index_follower_rolls_on_follower"
    t.index ["player_class_id"], name: "index_follower_rolls_on_player_class_id"
  end

  create_table "military_unit_followers", force: :cascade do |t|
    t.integer "experience", null: false
    t.integer "equipment", null: false
    t.integer "unit_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "retainer_classes", force: :cascade do |t|
    t.integer "player_subclass_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_subclass_id"], name: "index_retainer_classes_on_player_subclass_id"
  end

  create_table "source_materials", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "special_allies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ambassadors", "ancestries"
  add_foreign_key "follower_rolls", "player_classes"
  add_foreign_key "player_subclasses", "player_classes"
  add_foreign_key "retainer_classes", "player_subclasses"
end
