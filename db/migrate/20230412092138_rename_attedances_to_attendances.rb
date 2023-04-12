class RenameAttedancesToAttendances < ActiveRecord::Migration[7.0]
  def change
    rename_table :attedances, :attendances
  end
end
