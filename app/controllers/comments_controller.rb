class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        link ="<a href=events/#{Event.find(@comment.event_id).id}>#{Event.find(@comment.event_id).name}</a>"
        format.html { redirect_to  "/events/#{@comment.event_id}" , :notice => ("Comment was successfully created in #{link}.").html_safe }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    link ="<a href=events/#{Event.find(@comment.event_id).id}>#{Event.find(@comment.event_id).name}</a>"
    respond_to do |format|
      format.html { redirect_to(:root , :notice => ("Comment removed from #{link}.").html_safe) }
      format.xml  { head :ok }
    end
  end
end