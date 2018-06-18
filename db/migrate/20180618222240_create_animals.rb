class CreateAnimals < ActiveRecord::Migration[5.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :breed
      t.date :dob
      t.decimal :weight
      t.string :sex
      t.string :color
      t.boolean :fixed
      t.text :description
      t.string :type
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
