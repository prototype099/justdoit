class Api::TasksController < Api::BaseController

  def index

    logger.debug "params[:event_id] is #{params[:event_id]}"

    tasks = Task.includes(:user).includes(:user => :oauth_tokens)
    tasks = tasks.where(event_id: params[:event_id]) if params[:event_id]
    tasks = tasks.order(:updated_at).reverse_order

    respond_success_to message: 'OK', tasks: tasks.as_json(:include => { 
                                                              :user => {
                                                                :include => { :oauth_tokens => {:only => [:uid]} },
                                                                :only => [:name],
                                                              },
                                                            })
  end

  def create
    task = Task.new(task_params)
    task.user_id = current_user.id
    logger.debug "@task is #{@task.inspect}"
    
    is_new_member = false

    ActiveRecord::Base.transaction do 
      if task.save
        is_new_member = EventMember.create_if_not_exist(task.event_id, task.user_id)
      else
        raise "failed to create a task."
      end
    end

    respond_success_with( message: 'Task was successfully created.',
                              new_member: is_new_member,
                              task: task.as_json(:include => { 
                                                    :user => {
                                                      :include => { :oauth_tokens => {:only => [:uid]} },
                                                      :only => [:name],
                                                    },
                                                  })
                              )
  rescue => e
    logger.error e.message
    respond_failure_with(500, e.message)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:event_id, :user_id, :content, :state)
    end
end