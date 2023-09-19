class SetUpOtherFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :artisans do |t|
      t.column :name, :string, null: false, unique: true
      t.column :description, :string
      t.timestamps
    end

    create_table :ambassadors do |t|
      t.belongs_to :ancestry, index: true, foreign_key: true
      t.timestamps
    end

    create_table :military_unit_followers do |t|
      t.column :experience, :integer, null: false
      t.column :equipment, :integer, null: false
      t.column :unit_type, :integer, null: false
      t.timestamps
    end

    create_table :special_allies do |t|
      t.column :name, :string, null: false, unique: true
      t.timestamps
    end
  end
end
