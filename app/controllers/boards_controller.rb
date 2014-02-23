class BoardsController < ApplicationController

  before_filter :detect_event

  def index
    @tasks = Task.includes(:user).includes(:user => :oauth_tokens).where(event_id: @event.id)

    @task = Task.new(event_id: @event.id)
  end

  
end
