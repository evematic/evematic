class Evematic::SessionsController < Evematic::ApplicationController
  def new
    redirect_to after_login_path if logged_in?
  end

  def destroy
    log_out
    redirect_to after_logout_path
  end

  private

  def auth_controller?
    true
  end

  def log_out
    session[:current_identity_id] = nil
    session[:current_account_id] = nil
  end
end
