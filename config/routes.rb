Rails.application.routes.draw do

  # get 'demo' => 'demo#index'

  match ':controller(/:action(/:id))', via: [:get, :post]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
