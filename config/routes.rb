Rails.application.routes.draw do
  namespace :user do
    get "videos/index"
    get "videos/show"
    resources :videos, only: [ :index, :show ]
  end
  namespace :admin do
    resources :videos, only: [ :index, :new, :create, :show ]
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
end
