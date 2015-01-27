require 'rails_helper'

RSpec.describe "events/edit", :type => :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :name => "MyString",
      :run_time => "MyString",
      :description => "MyText",
      :venue_id => 1,
      :style => "MyString",
      :price => "MyString",
      :box_office_num => "MyString",
      :tickets_url => "MyString"
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_name[name=?]", "event[name]"

      assert_select "input#event_run_time[name=?]", "event[run_time]"

      assert_select "textarea#event_description[name=?]", "event[description]"

      assert_select "input#event_venue_id[name=?]", "event[venue_id]"

      assert_select "input#event_style[name=?]", "event[style]"

      assert_select "input#event_price[name=?]", "event[price]"

      assert_select "input#event_box_office_num[name=?]", "event[box_office_num]"

      assert_select "input#event_tickets_url[name=?]", "event[tickets_url]"
    end
  end
end
