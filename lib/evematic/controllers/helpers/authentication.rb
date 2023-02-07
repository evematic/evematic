module Evematic::Controllers::Helpers::Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :logged_in?, :current_account, :current_identity
  end

  def require_login!
    return true if current_identity

    flash[:error] = t("evematic.errors.login_required")
    store_location(request.fullpath)
    redirect_to login_path
  end

  def require_admin!
    not_found unless current_account&.admin?
  end

  def logged_in?
    current_identity_id.present?
  end

  def current_account_id
    session[:current_account_id]
  end

  def current_account
    @current_account ||= account_model.find_by(id: current_account_id)
  end

  def current_identity_id
    session[:current_identity_id]
  end

  def current_identity
    @current_identity ||= identity_model.includes(:character, :corporation, :alliance).find_by(id: current_identity_id)
  end

  # Helper methods taken from Devise
  # https://github.com/heartcombo/devise/blob/main/lib/devise/controllers/store_location.rb

  def storable_location?
    request.get? && request.format.to_sym == :html && !auth_controller? && !request.xhr?
  end

  def store_location(location)
    path = extract_path_from_location(location)
    session["return_to"] = path if path
  end

  def stored_location
    if request.format.to_sym == :html
      session.delete("return_to")
    else
      session["return_to"]
    end
  end

  def parse_uri(location)
    location && URI.parse(location)
  rescue URI::InvalidURIError
    nil
  end

  def extract_path_from_location(location)
    uri = parse_uri(location)

    if uri
      path = remove_domain_from_uri(uri)
      add_fragment_back_to_path(uri, path)
    end
  end

  def remove_domain_from_uri(uri)
    [uri.path.sub(/\A\/+/, "/"), uri.query].compact.join("?")
  end

  def add_fragment_back_to_path(uri, path)
    [path, uri.fragment].compact.join("#")
  end

  def after_login_path
    root_path
  end

  def after_logout_path
    root_path
  end
end
