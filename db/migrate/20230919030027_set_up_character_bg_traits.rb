class SetUpCharacterBgTraits < ActiveRecord::Migration[7.0]
  def change
    create_table :ancestries do |t|
      t.column :name, :string, null: false, unique: true
      t.timestamps
    end

    create_table :character_names do |t|
      t.column :value, :string, null: false, unique: true
      t.column :gender, :integer
      t.column :name_type, :integer, null: false
      t.timestamps
    end

    create_table :ancestries_character_names, id: false do |t|
      t.belongs_to :ancestry
      t.belongs_to :character_name
    end
  end
end
