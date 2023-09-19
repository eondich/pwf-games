class SetUpFollowerCharts < ActiveRecord::Migration[7.0]
  def change
    create_table :follower_rolls do |t|
      t.belongs_to :player_class, index: true, foreign_key: true
      t.column :min_roll, :number, null: false
      t.column :max_roll, :number, null: false
      t.references :follower, polymorphic: true
      t.column :follower_level, :number
      t.timestamps
    end
  end
end
