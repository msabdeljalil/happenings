class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :runt_time
      t.text :description
      t.integer :venue_id
      t.string :style
      t.string :price
      t.string :box_office_num
      t.string :tickets_url

      t.timestamps
    end
  end
end
