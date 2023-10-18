class RenameCharNameAncestries < ActiveRecord::Migration[7.0]
  def change
    rename_table :character_names_ancestries, :ancestries_character_names
    rename_column :ancestries_character_names, :given_name_id, :character_name_id
  end
end
