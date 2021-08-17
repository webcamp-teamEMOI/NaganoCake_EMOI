Rails.application.routes.draw do

  devise_for :admin,controllers:{
    sessions: "admin/sessions"
  }

  devise_scope :admin do
    get "admin/sign_in", to: "admin/sessions#new"
    post "admin/sign_in", to: "admin/sessions#create"
  end

  devise_for :customers,controllers:{
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :customers do
    get "customers/sign_up", to: "public/registrations#new"
    post "customers", to: "public/registrations#create"

    get "customers/sign_in", to: "public/sessions#new"
    post "customers/sign_in", to: "public/sessions#create"
    delete "customers/sign_out", to: "public/sessions#destroy"

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  scope module: :public do
    root to: "homes#top"
    get "about" => "items#about"
    resources :items,only:[:index,:show]
    resource :customers,only:[:edit,:update]
    resources :cart_items,only:[:index,:update,:destroy,:create]
    resources :orders,only:[:show,:create,:index,:new]
    resources :addresses,except:[:new,:show]
    get "customers/my_page" => "customers#show"
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    post "orders/confirm" => "orders#confirm"
    get "orders/complete" => "orders#complete"
  end

  namespace :admin do
    root to: "homes#top"
    resources :items,except:[:destroy]
    resources :genres,only:[:index,:create,:edit,:update]
    resources :customers,only:[:index,:show,:edit,:update]
    resources :orders,only:[:show,:update] do
      resources :order_details,only:[:update]
    end
  end

end
