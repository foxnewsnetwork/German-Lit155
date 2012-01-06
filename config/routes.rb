Gossip::Application.routes.draw do


  resources :comments, :only => [:create, :destroy]
  resources :macroposts, :only => [:destroy, :update, :edit, :new]

  devise_for :moderators
	resource :moderators, :only => [:show, :index] do
		member do
			resource :macroposts, :only => [:create]
		end
	end
  resources :people

  #get "areas/create"

  #match 'user/edit' => 'users#edit', :as => :edit_current_user
  #match 'signup' => 'users#new', :as => :signup
  #match 'logout' => 'sessions#destroy', :as => :logout
  #match 'login' => 'sessions#new', :as => :login

  # resources :sessions

  #resources :users

  match '/about' , :to => "pages#about"
  match '/misc' , :to => "pages#misc"
  match "/developer", :to => "pages#developer"
  match "/contact", :to => "pages#contact"
  match "/b", :to => "pages#discussion"
  
  resources :rumors, :only => [:create, :destroy]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "pages#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
