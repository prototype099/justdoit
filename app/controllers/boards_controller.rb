class BoardsController < ApplicationController

  before_filter :detect_event

  def index

    gon.event_id = @event.id
    gon.api_event_tasks_path = url_for(controller: 'api/tasks', action: :index, event_id: @event.id)
    gon.api_create_task_path = url_for(controller: 'api/tasks', action: :create)

    @tasks = Task.includes(:user).includes(:user => :oauth_tokens).where(event_id: @event.id)
    @task = Task.new(event_id: @event.id)

  end

  
end
