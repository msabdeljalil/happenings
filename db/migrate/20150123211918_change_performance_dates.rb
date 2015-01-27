class ChangePerformanceDates < ActiveRecord::Migration
  # These changes have been added to CreatePD's
  # This mig can now be deleted if creating new DB
  def change
    change_table :performance_dates do |t|
      t.rename :date, :dtstart
      t.datetime :dtend
    end
  end
  change_column :performance_dates, :date, :datetime
end
