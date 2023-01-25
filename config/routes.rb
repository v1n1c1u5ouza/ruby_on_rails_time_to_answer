Rails.application.routes.draw do
  namespace :admins_backoffice do
    get 'welcome/index' #bashboard
    resources :admins   #admistradores
    resources :subjects #assuntos/area
  end
  
  namespace :users_backoffice do
    get 'welcome/index'
  end

  namespace :site do
    get 'welcome/index'
  end

  devise_for :admins
  devise_for :users
  
  get "inicio", to: "site/welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "site/welcome#index"
end
