class AddEmployeeIdToListings < ActiveRecord::Migration
  def change
    add_column :listings, :employee_id, :integer
  end
end
