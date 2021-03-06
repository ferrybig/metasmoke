class StatusController < ApplicationController
  protect_from_forgery :except => [:status_update]
  before_action :check_if_smokedetector, :only => [:status_update]

  def index
    @statuses = SmokeDetector.order('last_ping DESC').all
  end

  def status_update
    @smoke_detector.last_ping = DateTime.now
    @smoke_detector.location = params[:location]

    @smoke_detector.save!

    respond_to do |format|
      format.json do
        render :status => 200, :plain => "hi there!"
      end
    end
  end
end
