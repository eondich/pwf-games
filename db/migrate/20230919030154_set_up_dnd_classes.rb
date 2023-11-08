class SetUpDndClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :player_classes do |t|
      t.column :name, :string, null: false, unique: true
      t.timestamps
    end

    create_table :player_subclasses do |t|
      t.belongs_to :player_class, index: true, foreign_key: true
      t.column :name, :string, null: false, unique: true
      t.timestamps
    end
  end
end
