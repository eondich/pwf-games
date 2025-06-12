class AddPlayerClassProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :player_classes, :name_modifier, :string
    add_column :player_classes, :name_modifier_is_prefix, :boolean, default: true
    add_column :player_classes, :hit_die, :number

    # Map game systems to subclasses
    create_table :game_systems_player_subclasses, id: false do |t|
      t.belongs_to :game_system
      t.belongs_to :player_subclass
    end
  end
end
