class CharNameTweaks < ActiveRecord::Migration[7.0]
  def change
    # This is what I get for reviewing my own code after a long day
    rename_table :character_name_ancetries, :character_name_ancestries

    # Wow does this mistake make me feel that I was born after 1990
    add_column :character_names, :gender, :integer
  end
end
