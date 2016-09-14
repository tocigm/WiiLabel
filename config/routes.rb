Rails.application.routes.draw do
  resources :items

  get 'items/:id/next', to: "items#next_item" , as: 'next_item'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
