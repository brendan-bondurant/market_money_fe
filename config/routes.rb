Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # root "articles#index"
  # Defines the root path route ("/")
  resources :markets, only: [:index, :show]
  resources :vendors, only: [:show] do
    get :market_search, on: :collection
  end
end
