class CreatePerformanceDates < ActiveRecord::Migration
  def change
    create_table :performance_dates do |t|
      # This table has been updated the way I like,
      # remove ChangePerforamanceDates mig if necessary
      t.datetime :dtstart
      t.datetime :dtend
      t.integer :event_id
    end
    add_index :performance_dates, :event_id
  end
end
