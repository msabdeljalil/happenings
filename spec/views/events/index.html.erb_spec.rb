require 'rails_helper'

RSpec.describe "events/index", :type => :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :name => "Name",
        :run_time => "Run Time",
        :description => "MyText",
        :venue_id => 1,
        :style => "Style",
        :price => "Price",
        :box_office_num => "Box Office Num",
        :tickets_url => "Tickets Url"
      ),
      Event.create!(
        :name => "Name",
        :run_time => "Run Time",
        :description => "MyText",
        :venue_id => 1,
        :style => "Style",
        :price => "Price",
        :box_office_num => "Box Office Num",
        :tickets_url => "Tickets Url"
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Run Time".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Style".to_s, :count => 2
    assert_select "tr>td", :text => "Price".to_s, :count => 2
    assert_select "tr>td", :text => "Box Office Num".to_s, :count => 2
    assert_select "tr>td", :text => "Tickets Url".to_s, :count => 2
  end
end
