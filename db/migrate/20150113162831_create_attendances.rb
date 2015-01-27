class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.integer :performance_date_id
    end
    add_index :attendance, [:user_id, :performance_date_id], unique:true
  end
end
