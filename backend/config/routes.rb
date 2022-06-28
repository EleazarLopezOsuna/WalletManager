Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :category, :type

    resources :transaction, except: [:index] do
      collection do
        get '/my_transactions/:user_id', to: 'transaction#user_transactions'
        get '/wallet_transactions/:wallet_id', to: 'transaction#wallet_transactions'
        get '/date/:wallet_id/:date', to: 'transaction#filter_by_date'
        get '/month/:wallet_id/:month', to: 'transaction#filter_by_month'
        get '/year/:wallet_id/:year', to: 'transaction#filter_by_year'
        get '/category/:wallet_id/:category', to: 'transaction#filter_by_category'
        get '/report/:wallet_id', to: 'transaction#report'
      end
    end

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
