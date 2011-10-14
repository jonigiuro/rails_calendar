class EventsController < ApplicationController
  before_filter :find_event, :only  => [:show, :destroy]

  def create
    @event = current_user.events.build(params[:event])
    if @event.body?
      @event.body = "-no description-"
    end
    @event.user_id=current_user.id
    if @event.one == true
      if @event.start_at.future? == false
         redirect_to( :root, :notice => 'Event should be in the future') and return
      end

      @event.start_at = ((@event.start_at).to_s.slice!(0..10)+"00:00:00").to_datetime
      @event.end_at = @event.start_at
      @event.end_at = ((@event.start_at).to_s.slice!(0..10)+"23:59:59").to_datetime
      @event.save
      link ="<a href=events/#{@event.id}>#{@event.name}</a>"
      redirect_to( :root, :notice => ("Event #{link} was successfully created.").html_safe) and return
    end

     if @event.one == false
       if @event.start_at.future? == false
         redirect_to( :root, :notice => 'Event should be in the future') and return
       end

       if @event.start_at > @event.end_at
         redirect_to( :root, :notice => 'Start time should be equal or greater than end time') and return
       end
    end
    @event.save
    link ="<a href=events/#{@event.id}>#{@event.name}</a>"
    redirect_to( :root, :notice => ("Event #{link} was successfully created.").html_safe) and return
  end

  def show
    @comments = Comment.where(:event_id => @event.id)
  end

  def destroy
    @event.destroy

    respond_to do |format|
      format.html {redirect_to( :root, :notice => 'Event removed.')}
      format.xml  { head :ok }
    end
  end

  def day
    if Event.count != 0
      @event = Event.last
    end
    @year = params[:year]
    @month = params[:month]
    @day = params[:day]
    @date = (@year+'-'+@month+'-'+@day)
    if Event.count != 0
      @prova = Event.last.start_at.to_s.slice(0..9)
    
    @events=[]
    Event.all.each do |event|
      sliced_start = (event.start_at).to_s.slice(0..9)
      sliced_end = (event.end_at).to_s.slice(0..9)
      if sliced_start < @date && sliced_end > @date
        @events << event
      end

      if sliced_start == @date
        @events << event
      end

      if sliced_end == @date && sliced_start < @date
        event.start_at = (event.start_at.to_s).slice(0..9) + ' 00:00'
        @events << event
      end

      if sliced_end > @date && sliced_start < @date
        event.start_at = (event.start_at.to_s).slice(0..9) + ' 00:00'
        event.end_at = (event.end_at.to_s).slice(0..9) + ' 23:59'
        @events << event
      end

      if sliced_start == @date && sliced_end < @date
        event.end_at = (event.end_at.to_s).slice(0..9) + ' 23:59'
        @events << event
      end
    end
    end
    if Event.count != 0
    @events.uniq!
  end
  end

  protected
    def find_event
      @event = Event.find(params[:id])
    end
end