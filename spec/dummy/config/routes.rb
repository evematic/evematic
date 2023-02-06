Rails.application.routes.draw do
  mount Evematic::Engine, at: "/evematic"

  root to: 'welcome#index'
end
