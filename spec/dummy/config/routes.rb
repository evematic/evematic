Rails.application.routes.draw do
  evematic_authentication

  resource :dashboard, only: [:show]

  root to: "welcome#index"
end
