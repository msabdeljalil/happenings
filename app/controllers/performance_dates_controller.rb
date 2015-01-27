class AttendancesController < ApplicationController
  # before_action :authenticate_user!

  # TODO: This method can cleaned up with another private method
  def add_attendance
    redirect_to events_path unless request.xhr?
    p_date = PerformanceDate.find(params[:id])

    unless current_user.performance_dates.include? p_date
      current_user.performance_dates << p_date
      flash[:notice] = "Event has been added to your calendar!"
    else
      flash[:notice] = "This event is already in your calendar."
    end
    # TODO: If we use the 'render' below, we'll have to do the 'flash.notice' in the JS
    # Maybe...for some reason it's just not working anyways
    # render nothing: true
    respond_to do |format|
      # What's the appropritate way to respond to an ajax call?
      format.js { render js: "{JS:'success js'}" }
    end
  end

end
