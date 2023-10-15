class MakeCharNamesGeneric < ActiveRecord::Migration[7.0]
  def change
    drop_table :surnames
    drop_table :surname_ancestries

    rename_table :given_names, :character_names
    rename_table :given_name_ancestries, :character_name_ancetries

    # Will do this as an enum as it's unlikely to get used anywhere else
    # Examples: Given name, family name, clan name, nickname, etc.
    add_column :character_names, :name_type, :integer, null: false

    # Doing this as a table as it will probably get used in a few places,
    # and we might want to make the data stored with it more complicated
    create_table :source_materials do |t|
      t.column :name, :string, null: false, unique: true
      t.timestamps
    end

    create_table :character_name_source_materials, id: false do |t|
      t.belongs_to :character_name
      t.belongs_to :source_material
    end
  end
end
