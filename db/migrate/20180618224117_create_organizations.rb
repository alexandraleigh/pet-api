class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :phone
      t.string :website
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.string :zipcode
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
