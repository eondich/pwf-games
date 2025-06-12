class AddKeyToGameSystem < ActiveRecord::Migration[7.0]
  def change
    add_column :game_systems, :key, :string, required: true
  end
end
