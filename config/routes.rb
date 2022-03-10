Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  root to: 'public/homes#top'
  get  '/about' => 'public/homes#about'


  scope module: :public do
    get "/customers/my_page" => "customers#show"
     get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
     patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    resources :items
    resources :customers
    resources :homes
    
    resources :cart_items do
      collection do
        delete 'destroy_all'
       end
      end
  end

 namespace :admin do
    root to: 'homes#top'
    resources :genres
    resources :items
    resources :customers

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
