class AddNeedsPasswordToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :needs_password, :boolean
  end
end
