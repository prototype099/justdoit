class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # filter StrongParameter for devise 
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :email) }
  end

  def detect_event
    @event = Event.find(params[:event_id])
    redirect_to root_url, alert: "invalid url" and return unless @event
  end

end
