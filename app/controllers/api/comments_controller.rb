class Api::CommentsController < Api::BaseController

  def index

    comments = Comment.includes(user: :oauth_tokens)
                        .where(task_id: params[:task_id])
                        .order(:id).reverse_order

    respond_success_to message: 'OK', comments: comments.as_json(:include => { 
                                                                  :user => {
                                                                    :include => { :oauth_tokens => {:only => [:uid]} },
                                                                    :only => [:id],
                                                                  },
                                                                })
  end

  def create

    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    logger.debug "comment is #{comment.inspect}"

    if comment.save
      respond_success_with  message: 'Comment was successfully created.',
                            comment: comment.as_json(:include => { 
                                                        :user => {
                                                          :include => { :oauth_tokens => {:only => [:uid]} },
                                                          :only => [:id],
                                                        },
                                                      }) 

    else
      respond_failure_with(500, 'failed to create a comment.')
    end

  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:task_id, :user_id, :body)
    end

end