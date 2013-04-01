#Jobless::Application.routes.draw do
#  devise_for :employers
#
#  devise_for :employees
#
#  authenticated :user do
#    root :to => 'home#index'
#  end
#  root :to => "home#index"
#  devise_for :users
#  resources :users
#end

Jobless::Application.routes.draw do

  root to: 'home#index'

  devise_for :employees, controllers: { sessions: 'employees/sessions' }
  post 'employees/set_password' => 'employees#set_password'

  scope module: 'employees' do
    resources :listings

    scope '/employees' do
      resource :employee_details, only: [ :edit, :update, :create ] do
        post :remove_avatar, :on => :collection
      end
      

      resources :cv_views, only: [ :index, :destroy ] do
        post :batch_destroy, :on => :collection
      end
      post '/set_cover_cv/:id' => 'employee_details#set_cover_cv', as: 'set_cover_cv'
      post '/remove_cover_cv' => 'employee_details#remove_cover_cv', as: 'remove_cover_cv'

      scope '/:employee_id' do
        get '' => 'profiles#show', as: 'employee_profile'
        get '/cvs/:id' => 'cvs#show', as: 'employee_cv'
      end
    end
  end

  devise_for :employers, :controllers => { registrations: "employers/registrations", sessions: 'employers/sessions' }



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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end