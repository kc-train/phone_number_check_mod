PhoneNumberCheckMod::Engine.routes.draw do
  root 'home#index'
  resources :messages do
    collection do
      get :check_validation
      post :check_validation
    end
  end
end