Hpjsdemo::Application.routes.draw do
  resources :pads do
    resource 'embed', :only => :show do
      get 'nosig'
      get 'noemail'
      get 'script'
    end
    resources 'revisions', :only => [ :index, :show ]
  end

  resources :notes do
    resources :chapters do
      resources :sections
    end
  end

  resources :chapters do
    resources :sections
  end

  resources :sections do
    resources :questions
  end

  resources :questions
  
  post 'sections/:id/copy', to: 'sections#copy'

  get 'home' ,to: 'home#index'
  root 'home#index'


  get 'auth/facebook', as: "fb_login"
  get 'auth/facebook/callback', to: 'sessions#create'#'users#login'
  get 'signout', to: 'sessions#destroy', as: 'signout'

end
