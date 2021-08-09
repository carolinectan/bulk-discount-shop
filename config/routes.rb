Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchant, only: [:show] do #, module: :merchants do
    resources :dashboard, only: [:index]
    # /merchant/6/dashboard
    # /merchant/:merchant_id/dashboard
    resources :items, except: [:destroy]
    # /merchant/6/items
    resources :item_status, only: [:update] # no html bc update; prob a form
    resources :invoices, only: [:index, :show, :update]
    # /merchant/6/invoices
    resources :bulk_discounts
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    # /admin/dashboard
    resources :merchants, except: [:destroy] # legacy error
    resources :merchant_status, only: [:update] # no html bc update; prob a form
    resources :invoices, except: [:new, :destroy]
    # /admin/invoices/6

  end

  get '/', to: 'pages#home'
end
