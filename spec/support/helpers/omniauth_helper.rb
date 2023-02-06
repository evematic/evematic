module OmniAuth::ControllerSpecHelper
  def log_in(identity)
    session[:current_identity_id] = identity.id
    session[:current_account_id] = identity.account_id
  end
end

module OmniAuth::RequestSpecHelper
  def log_in(identity)
    OmniAuth.config.mock_auth[:eve] = OmniAuth::AuthHash.new(
      {provider: :eve, uid: identity.character_id}
    )
    allow(Evematic::AccessRule).to receive(:allows?).and_return(true)
    post("/auth/eve")
    follow_redirect! # /auth/eve/callback
    follow_redirect! # /
  end
end
