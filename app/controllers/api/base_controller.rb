class Api::BaseController < ApplicationController

  respond_to :json

  protected

  def respond_success_to(options={})
    render json: {success: true}.merge(options)
  end

  def respond_failure_to(code, message, options={})
    render json: {success: :false, error_code: code, error_message: message}.merge(options)
  end

  def respond_success_with(options={})
    respond_with({success: true}.merge(options), status: 200, location: nil)
  end

  def respond1_failure_with(code, message, options={})
    respond_with({success: false, error_code: code, error_message: message }.merge(options), status: code, location: nil)
  end

end