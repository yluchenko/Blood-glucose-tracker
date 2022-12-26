class CreateReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :readings do |t|
      t.integer :level
      t.references :user
      t.timestamps
    end
  end
end
