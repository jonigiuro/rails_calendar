class AttendsController < ApplicationController

  def create
    @attend = Attend.new(params[:attend])
    @attend.save
    link ="<a href=events/#{Event.find(@attend.event_id).id}>#{Event.find(@attend.event_id).name}</a>"

    respond_to do |format|
      format.html { redirect_to "/events/#{@attend.event_id}" , :notice => ("You will attend #{link}").html_safe }
      format.js
    end
  end
end