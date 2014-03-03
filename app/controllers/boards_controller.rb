class BoardsController < ApplicationController

  before_filter :detect_event

  def index

    gon.event_id = @event.id
    gon.api_tasks_path = url_for(controller: 'api/tasks', action: :create)


    @tasks = Task.includes(:user).includes(:user => :oauth_tokens).where(event_id: @event.id)
    @task = Task.new(event_id: @event.id)
  end

  
end
