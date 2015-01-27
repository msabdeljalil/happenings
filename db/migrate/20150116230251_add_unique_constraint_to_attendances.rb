class AddUniqueConstraintToAttendances < ActiveRecord::Migration
  def change
   execute  "ALTER TABLE attendances ADD CONSTRAINT  uniqueness UNIQUE (user_id, performance_date_id)"
  end
end
