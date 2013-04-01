class CreateListings < ActiveRecord::Migration
  def up
    create_table :listings do |t|
      t.string :current_occupation, :null => false
      t.integer :current_salary, :null => false
      t.string :city, :null => false
      t.string :future_occupation, :null => false
      t.integer :future_salary, :null => false
      t.integer :user_id

      t.timestamps
    end
  end

  def down
    drop_table :listings
  end
end
