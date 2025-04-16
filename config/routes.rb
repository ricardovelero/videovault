Rails.application.routes.draw do
  get "invites/show"
  namespace :user do
    get "dashboard", to: "dashboard#index"
    resources :videos, only: [ :index, :show ]
    resources :invitations, only: [ :new, :create, :index, :destroy ]
  end

  get "/invite/:token", to: "invites#show", as: :invite

  namespace :admin do
    resources :videos
  end

  devise_for :users

  authenticated :user, ->(u) { u.admin? } do
    root to: "admin/dashboard#index", as: :admin_root
  end

  authenticated :user, ->(u) { u.user? } do
    root to: "user/dashboard#index", as: :user_root
  end

  unauthenticated do
    root to: "home#index"
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
