class MapAncestriesToSources < ActiveRecord::Migration[7.0]
  def change
    create_table :source_materials do |t|
      t.column :name, :string, null: false, unique: true
      t.timestamps
    end

    create_table :ancestries_source_materials, id: false do |t|
      t.belongs_to :ancestry
      t.belongs_to :source_material
    end

    create_table :player_classes_source_materials, id: false do |t|
      t.belongs_to :player_class
      t.belongs_to :source_material
    end
    
    create_table :player_subclasses_source_materials, id: false do |t|
      t.belongs_to :player_subclass
      t.belongs_to :source_material
    end

    create_table :character_names_source_materials, id: false do |t|
      t.belongs_to :character_name
      t.belongs_to :source_material
    end
  end
end
