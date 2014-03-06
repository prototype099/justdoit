class Api::EventMembersController < Api::BaseController

  def index

    members = EventMember.includes(user: :oauth_tokens).where(event_id: params[:event_id])

    respond_success_to message: 'OK', members: members.as_json(:include => { 
                                                                :user => {
                                                                  :include => { :oauth_tokens => {:only => [:uid]} },
                                                                  :only => [:id],
                                                                },
                                                              })

  end

end