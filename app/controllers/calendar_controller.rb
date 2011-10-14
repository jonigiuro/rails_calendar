class CalendarController < ApplicationController

  def index
    @todays=[]
    all_evs = Event.all
    all_evs.each do |sing_ev|
      if sing_ev.start_at > Time.now
        @todays << sing_ev
      end
    end
    @event = Event.new
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = Event.event_strips_for_month(@shown_month)
  end

  def show
    @event = Event.find(params[:id])
  end
end