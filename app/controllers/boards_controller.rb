class BoardsController < ApplicationController

  before_filter :detect_event

  def index

    @tasks = Task.where(event_id: @event_id)

  end

  
end
