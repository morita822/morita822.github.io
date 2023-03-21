class CreateAttedances < ActiveRecord::Migration[7.0]
  def change
    create_table :attedances do |t|
      t.integer :employee_id
      t.date :date
      t.integer :attendance_status
      t.string :shift_status

      t.timestamps
    end
  end
end
