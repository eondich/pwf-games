class MapAncestriesToSources < ActiveRecord::Migration[7.0]
  def change
    create_table :ancestries_source_materials, id: false do |t|
      t.belongs_to :ancestry
      t.belongs_to :source_material
    end

    create_table :player_class_source_materials, id: false do |t|
      t.belongs_to :player_class
      t.belongs_to :source_material
    end
    
    create_table :player_subclass_source_materials, id: false do |t|
      t.belongs_to :player_subclass
      t.belongs_to :source_material
    end

    # Now I am more awake!
    rename_table :character_name_ancestries, :character_names_ancestries
    rename_table :character_name_source_materials, :character_names_source_materials
  end
end
