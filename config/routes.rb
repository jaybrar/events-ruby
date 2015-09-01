Rails.application.routes.draw do
  root 'sessions#new'

  get '/sessions/new' => 'sessions#new'
  post '/sessions' => 'sessions#log_in'
  delete '/sessions' => 'sessions#log_out'

  get '/users/:id' => 'users#show'
  get '/users' => 'users#index'
  # get '/users/new' => 'users#new'
  get '/users/:id/edit' => 'users#edit'
  post '/users/new' => 'users#create'
  patch '/users/:id' => 'users#update'
  # delete '/users/:id' => 'users#destroy'

  get '/events' => 'events#index'
  get '/events/:id' => 'events#show'
  get '/events/:id/edit' => 'events#edit'
  post '/events' => 'events#create'
  patch '/events/:id' => 'events#update'
  delete '/events/:id' => 'events#destroy'

  post '/attendees/:id' => 'attendees#create'
  delete '/attendees/:id' => 'attendees#destroy'

  post '/comments/:id' => 'comments#create'

  get '/resources' => 'resources#index'
  get '/resources/:id/edit' => 'resources#edit'
  get '/resources/:id/delete' => 'resources#destroy'
  post '/resources' => 'resources#create'
  patch '/resources/:id' => 'resources#update'


  get '/messages/:id/delete' => 'messages#destroy'
  post '/messages' => 'messages#create'
  post '/messages2' => 'messages#create2'
  post '/messages-blast' => 'messages#message_all'

  post '/email' => 'emails#create'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
