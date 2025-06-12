class AddBackgroundsAndStats < ActiveRecord::Migration[7.0]
  def change
    create_table :backgrounds do |t|
      t.column :name, :string, null: false
      t.belongs_to :game_system
    end

    create_table :character_stats do |t|
      t.column :name, :string, null: false
      t.column :abbreviation, :string, null: false
      t.belongs_to :game_system
    end

    create_table :backgrounds_character_stats, id: false do |t|
      t.belongs_to :background
      t.belongs_to :character_stat
    end
  end
end
