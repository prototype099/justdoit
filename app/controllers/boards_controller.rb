class BoardsController < ApplicationController

  before_filter :detect_event

  def index
    @tasks = Task.where(event_id: @event.id)
    @task = Task.new(event_id: @event.id)
  end

  
end
