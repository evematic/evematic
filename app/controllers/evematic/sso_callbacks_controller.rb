class Evematic::SSOCallbacksController < Evematic::ApplicationController
  def eve
    auth = request.env["omniauth.auth"]
    character = esi_character_model.find_or_create_by(id: auth.uid)
    identity = identity_model.sso_authenticate_by(character)
    if identity&.persisted?
      log_in(identity)
      redirect_to(stored_location || after_login_path)
    else
      flash[:error] = t(".forbidden", name: character.name)
      redirect_to login_path
    end
  end

  def failure
    flash.now[:error] = t(".not_authorized")
    redirect_to login_path
  end

  private

  def auth_controller?
    true
  end

  def log_in(identity)
    session[:current_identity_id] = identity.id
    session[:current_account_id] = identity.account_id
  end
end
