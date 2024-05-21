Rails.application.routes.draw do
  
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:index, :show, :new, :create]
    post 'orders/confirm'
    get 'orders/complete'
    resources :cart_items, only: [:index, :create, :update]
    get 'customers/show' => 'customers#show', as: 'customer'
    get 'customers/edit' => 'customers#edit', as: 'edit_customers'
    patch 'customers' => 'customers#update', as: 'customers'
    resources :items, only: [:index, :show] 
  end
  
  namespace :admin do
    resources :orders, only: [:update, :show] 
    #patch 'orders' => 'orders#update', as: 'orders'
    resources :customers, only: [:index, :show] 
    resources :items
  end
  
    # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    get '/' => 'homes#top', as: 'top'
  end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
