class PasswordsController < Devise::PasswordsController
  layout 'facebox', :only => [:new]

  def new
    super
  end

  def create
    self.resource = resource_class.send_reset_password_instructions(params[:user])

    if successfully_sent?(resource)
      @status = true
      respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
    else
      @status = false
      respond_with(resource)
    end
  end

  
end
