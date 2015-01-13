Feature: List Events
	In order to add events to my calendar
	As a user
	I want to search for events by filtering across time

	Scenario: View a list of upcoming events
		Given I am on the events list page
		Then I want to see upcoming events within 3 days

	Scenario: Filter events based on day
		Given I am on the events list page
		When I want filter for events on a given day
		I expect to see all events in that day

	Scenario: Filter events based on week
		Given I am on the events list page
		When I want filter for events within a week
		I expect to see all events in that week

	Scenario: Filter events based on month
		Given I am on the events list page
		When I want filter for events within a month
		I expect to see all events in that month
