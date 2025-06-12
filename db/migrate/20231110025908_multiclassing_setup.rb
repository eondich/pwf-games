class MulticlassingSetup < ActiveRecord::Migration[7.0]
  def change
    add_column :player_subclasses, :num_additional_classes_allowed, :number, default: 0
  end
end
