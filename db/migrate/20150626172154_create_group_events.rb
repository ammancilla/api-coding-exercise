class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.date :start_on
      t.date :end_on
      t.integer :duration
      t.string :name
      t.text :description
      t.string :location
      t.boolean :removed, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
