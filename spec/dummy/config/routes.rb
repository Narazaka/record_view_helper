Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tests, only: [] do
    collection do
      get :true
      get :false
    end
  end
end
