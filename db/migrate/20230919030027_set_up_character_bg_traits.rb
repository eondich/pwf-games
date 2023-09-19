class SetUpCharacterBgTraits < ActiveRecord::Migration[7.0]
  def change
    create_table :ancestries do |t|
      t.column :name, :string, null: false, unique: true
      t.timestamps
    end

    create_table :given_names do |t|
      t.column :value, :string, null: false, unique: true
      t.timestamps
    end

    create_table :surnames do |t|
      t.column :value, :string, null: false, unique: true
      t.timestamps
    end

    create_table :given_name_ancestries, id: false do |t|
      t.belongs_to :ancestry
      t.belongs_to :given_name
    end

    create_table :surname_ancestries, id: false do |t|
      t.belongs_to :ancestry
      t.belongs_to :surname
    end
  end
end
