Rails.application.routes.draw do
 root 'home_page#index'

 get    ':controller(/:action(/:user_name))', :constraints => { :user_name => /[^\/]+/ }
 post   ':controller(/:action(/:user_name))', :constraints => { :user_name => /[^\/]+/ }
 patch   ':controller(/:action(/:user_name))', :constraints => { :user_name => /[^\/]+/ }
 patch  '/admin/update_admin/:user_name' => 'admin#update_admin',:constraints => { :user_name => /[^\/]+/ }
 delete 'logout' =>  'login#logout'
 get    'edit_view' => 'admin#edit_view/:user_name', :constraints => { :user_name => /[^\/]+/ }
 get    'search' =>   'admin#search/:user_name', :constraints => { :user_name => /[^\/]+/ }
get 'about' => 'home_page#about'
get 'contact' => 'home_page#contact'

 
 resources :admin
 resources :book
 resources :user
 resources :checkout_detail
 resources :request
 resources :book_request
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
