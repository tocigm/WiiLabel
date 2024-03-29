Rails.application.routes.draw do
  get 'admins/index'

  resources :items
  resources :admins

  root to: "items#index"

  get 'items/:id/next', to: "items#next_item" , as: 'next_item'
  get 'items/:id/prev', to: "items#prev_item" , as: 'prev_item'

  get 'admins/update_category', to: 'admins#update_category', as: "update_category"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
