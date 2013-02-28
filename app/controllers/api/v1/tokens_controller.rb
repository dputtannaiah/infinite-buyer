class Api::V1::TokensController < Api::V1::BaseController
  skip_before_filter :authenticate_user

  respond_to :json

  #request POST tokens/:provider/:id.json
  #response {"token":"YzoCKNhadLsyFpHVXhhp"}
  def create
    provider = params[:provider]
    id = params[:id]

    if provider.nil? or id.nil?
      respond_with({:message=> "The request must contain the provider and id."}, :status => 400)
      return
    end

    if provider == "twitter"
      @user = User.find_or_create_for_twitter id
    elsif provider == 'facebook'
      @user = User.find_or_create_for_facebook id
    else
      respond_with({:message=> "provider is not valid."}, :status => 400)
      return
    end

    if @user.nil?
      render :status => 401, :json => {:message => "Invalid login or password."}
      return
    end
    @user.save(:validate => false)
    @user.ensure_authentication_token!

    render :status => 200, :json => {:token=>@user.authentication_token}
  end

  #request DELETE tokens/:token.json
  #response {"token":"YzoCKNhadLsyFpHVXhhp"}
  def destroy
    @user= User.find_by_authentication_token(params[:token])
    if @user.nil?
      render :status => 404, :json => {:message=> "Invalid token."}
    else
      @user.reset_authentication_token!
      render :status => 200, :json => {:token=> params[:token]}
    end
  end

end