Rails.application.routes.draw do
  root 'homepage#index'
  get "order_stream", to: "orders#stream"
  # config/routes.rb
  resources :drivers, only: [] do
    member do
      patch :update_location
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
