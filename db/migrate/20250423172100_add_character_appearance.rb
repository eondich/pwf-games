class AddCharacterAppearance < ActiveRecord::Migration[7.0]
  def change
    create_table :character_appearances do |t|
      t.column :appearance, :string, null: false
      t.belongs_to :game_system
    end
  end
end
