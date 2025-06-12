class CreateNameStyle < ActiveRecord::Migration[7.0]
  def change
    create_table :name_styles do |t|
      t.column :style, :string, null: false, unique: true
      t.timestamps
    end

    create_table :character_names_name_styles, id: false do |t|
      t.belongs_to :character_name
      t.belongs_to :name_style
    end

    create_table :game_systems_name_styles, id: false do |t|
      t.belongs_to :game_system
      t.belongs_to :name_style
    end
  end
end
