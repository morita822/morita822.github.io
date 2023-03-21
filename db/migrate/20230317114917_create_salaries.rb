class CreateSalaries < ActiveRecord::Migration[7.0]
  def change
    create_table :salaries do |t|
      t.integer :employee_id
      t.integer :basic_salary
      t.integer :overtime_salary

      t.timestamps
    end
  end
end
