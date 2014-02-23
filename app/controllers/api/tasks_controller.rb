class Api::TasksController < Api::BaseController

  def index
    respond_success_with(message: 'OK')
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    logger.debug "@task is #{@task.inspect}"

    unless @task.save
      respond_success_with({message:'Task was successfully created.'}.merge(task_params))
    else
      respond1_failure_with(500, 'NG');
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:event_id, :user_id, :content, :state)
    end
end