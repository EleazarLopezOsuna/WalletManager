Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :category, :type

    resources :transaction, except: [:index] do
      collection do
        get '/my_transactions/:user_id', to: 'transaction#user_transactions' #Ya
        get '/wallet_transactions/:wallet_id', to: 'transaction#wallet_transactions' #Ya
        get '/date/:wallet_id/:date', to: 'transaction#filter_by_date' #Ya
        get '/month/:wallet_id/:month', to: 'transaction#filter_by_month' #Ya
        get '/year/:wallet_id/:year', to: 'transaction#filter_by_year' #Ya
        get '/category/:wallet_id/:category', to: 'transaction#filter_by_category' #Pendiente
        get '/report/:wallet_id', to: 'transaction#report' #Pendiente
      end
    end

    resources :wallet, except: [:index] do
      collection do
        get '/my_wallets/:user_id', to: 'wallet#user_wallets' #Ya
        get '/user/summary/:user_id', to: 'wallet#summary' #Ya
      end
    end

    resources :user, except: [:create] do
      collection do
        post :login #Ya
        post :register
      end
    end

  end
end
