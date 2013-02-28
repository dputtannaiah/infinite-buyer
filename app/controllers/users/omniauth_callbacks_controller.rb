class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(*providers)
    providers.each do |provider|
      class_eval %Q{
        def #{provider}
          @user = User.find_or_create_for_#{provider} env["omniauth.auth"]
          @user.set_logged_in_as session[:logged_in_as]
          current_user = @user
          flash[:notice] = "Signed in with #{provider.to_s.titleize} successfully."
          sign_in @user
          redirect_to session[:referer].presence || root_url
        end 
      }
    end
  end
  provides_callback_for :facebook, :twitter
end