class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.integer :employee_id
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
