Athena::Application.routes.draw do
  devise_for :admin, controllers: { sessions: "admin/sessions" }
  namespace :admin do
    root to: "home#dashboard"

    resources :esas do
      resources :areas
      post :update_row_order, on: :collection
    end

    resources :areas do
      resources :items, only: [:index, :destroy]
      resources :recommendations
      post :update_row_order, on: :collection
    end

    resources :items, only: [:index, :create] do
      collection do
        post :update_row_order
        get :update_areas
      end  
    end

    resources :recommendations do
      resources :steps
    end

    resources :steps do 
      collection do
        get :update_recommendations
      end 
    end 

    resources :esa_types

  end

  devise_for :user, controllers: { sessions: "front/sessions" }
  namespace :front, path: "" do
    root to: "esas#index"
    resources :esas, only: [:index, :show] do
      resources :areas, only: [:index, :show, :create, :update] do
        post 'create', on: :member, as: 'create'
        get 'edit/:recommendation_by_user', to: 'areas#edit', as: 'recommendation_by_user'
      end
    end
    # resources :items, only: [:show, :update]
    resources :recommendations, only: [:show], as: 'recommendation_by_user' do
      member do
        get :purchase
        get :steps
        get :share
        post :send_mail
      end
    end
    # resources :steps, only: [:show]
    resources :congratulations, only: [:show]
    # resources :shopping, only: [:show ] do
    #   post 'send_list', on: :collection
    # end
    # resources :share, only: [:show]
  end
end