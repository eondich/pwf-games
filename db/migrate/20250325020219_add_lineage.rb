class AddLineage < ActiveRecord::Migration[7.0]
  def change
    create_table :lineages do |t|
      t.column :name, :string, null: false
      t.belongs_to :ancestry
      t.belongs_to :game_system
      t.timestamps
    end
  end
end
