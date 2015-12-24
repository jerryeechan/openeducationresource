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
end
