class Api::V1::BaseController < ActionController::Base
  respond_to :json

  before_filter :authenticate_user

  private
  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
    unless @current_user
      respond_with({:error => "Token is invalid."})
    end
  end

  def authorize_admin!
    unless @current_user.admin?
      error = {:error => "You must be an admin to do that."}
      render params[:format].to_sym => error, :status => 401
    end
  end

  def current_user
    @current_user
  end
end