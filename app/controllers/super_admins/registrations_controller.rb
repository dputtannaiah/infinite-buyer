class SuperAdmins::RegistrationsController < Devise::RegistrationsController
  protected
  def after_inactive_sign_up_path_for(resource)
    new_super_admin_session_path
  end

  def after_sign_up_path_for(resource)
    new_super_admin_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    current_super_admin_offers_path
  end

  def after_sign_out_path_for(resource_or_scope)
    super_admin_root_path
  end
end