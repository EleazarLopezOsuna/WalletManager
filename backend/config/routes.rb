Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :category, :transaction, :type, :wallet
    resources :user, except: [:create] do
      collection do
        post :login
        post :register
      end
    end
  end
end
