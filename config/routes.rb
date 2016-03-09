Rails.application.routes.draw do
  
  resources :authors do
  	match :batch_create, via: [:post], on: :collection
  	match :batch_update, via: [:put], on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
