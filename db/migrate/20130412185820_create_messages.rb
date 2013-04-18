class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :from_email
      t.integer :employee_id
      t.text :body

      t.timestamps
    end
  end
end
