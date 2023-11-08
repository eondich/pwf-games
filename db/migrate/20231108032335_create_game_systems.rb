class CreateGameSystems < ActiveRecord::Migration[7.0]
  def change
    create_table :game_systems do |t|
      t.column :name, :string, null: false
      t.timestamps
    end

    create_table :ancestries_game_systems, id: false do |t|
      t.belongs_to :ancestry
      t.belongs_to :game_system
    end

    create_table :game_systems_player_classes, id: false do |t|
      t.belongs_to :player_class
      t.belongs_to :game_system
    end

    create_table :character_names_game_systems, id: false do |t|
      t.belongs_to :character_name
      t.belongs_to :game_system
    end
  end
end
