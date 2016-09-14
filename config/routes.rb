Rails.application.routes.draw do
  resources :items

  get 'items/:id/next', to: "items#next_item" , as: 'next_item'
  get 'items/:id/prev', to: "items#prev_item" , as: 'prev_item'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
