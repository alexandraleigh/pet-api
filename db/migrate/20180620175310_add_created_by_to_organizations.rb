class AddCreatedByToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :created_by, :string
  end
end
