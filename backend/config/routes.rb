Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :category, :transaction, :type

    resources :wallet, except: [:index] do
      collection do
        get '/my_wallets/:user_id', to: 'wallet#user_wallets'
        get '/user/:user_id', to: 'wallet#totals'
      end
    end

    resources :user, except: [:create] do
      collection do
        post :login
        post :register
      end
    end

  end
end
