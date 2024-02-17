Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  locales = I18n.available_locales.join('|')
  scope '(:locale)', locale: /#{locales}/ do
    devise_for :users
    # Defines the root path route ("/")
    # root "articles#index"
    root 'posts#index'
    resources :posts
    resources :spaces do
      resources :users, only: %i[create], controller: 'spaces/users'
    end
    resources :links, only: %i[show create destroy], param: :sku
    resources :users, only: %i[index edit update destroy]
    get '/open-modal', to: 'pages#open_modal', as: 'open_modal'
  end
end
