Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :category, :transaction, :type, :user, :wallet
  end
end
