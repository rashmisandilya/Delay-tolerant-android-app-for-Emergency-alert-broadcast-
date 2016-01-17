Rails.application.routes.draw do

  resources :users do
    member do
      get 'get_groups'
      get 'get_join_groups'
      post 'join_group'
      post 'leave_group'
      post 'sendGCM'
      post 'sendGCMtoGroup'
      post 'update_gps'
      post 'update_regid'
      post 'join_group_batch'
      post 'leave_group_batch'
    end
  end
  resources :groups do
    member do
      get 'get_members'
    end
  end
  resources :messages do
    collection do
      post 'get_messages'
    end
  end

  get 'main_page/index'
  root 'main_page#index'

  post '/login', to: 'main_page#login'
  post '/login_front', to: 'main_page#login_front'
  post '/signup', to: 'main_page#signup'
  delete '/logout' => 'main_page#destroy'
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
