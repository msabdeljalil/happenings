class UsersController < ApplicationController
  before_action :set_user, only: [:show, :export_events, :print_calendar]


  def show
    @attds = @user.attendances.includes(:performance_date, :event)
  end

  def print_calendar
    generate_calendar()

    respond_to do |format|
      format.ics {
        @cal.publish # => ?
        render text:@cal.to_ical, type:"text/calendar", :callback => 'show'
        # send_data(@cal.export, :filename=>"mycal1.ics",  :disposition=>"inline; filename=mycal.ics", :type=>"text/calendar")
      }
    end
  end 


  private
    def set_user
      @user = current_user
    end

    def event_params
      params.require(:user).permit(:performance_dates)
    end

    def generate_calendar
      require 'icalendar'
      @cal = Icalendar::Calendar.new
      @cal.timezone { |t| t.tzid = "America/Chicago" }

      attds = @user.attendances.includes(:performance_date, :event)
      attds.each do |attendance|
        @cal.event do |e|
          e.uid         = self.uid # Ensure permanent UID so subsequent exports (or RSS feeds) of event will be updates. 
          e.dtstart     = Icalendar::Values::Date.new(attendance.performance_date.dtstart)
          e.dtend       = Icalendar::Values::Date.new(attendance.performance_date.dtend)
          e.description = attendance.performance_date.event.description
          e.organizer   = Icalendar::Values::CalAddress.new("mailto:#{@user.email}", cn: "#{@user.email}")
          e.ip_class    = "PRIVATE"
        end
      end
    end

end # => UsersControlller
