Rails.application.routes.draw do
  # devise_for :users
  mount Resque::Server, at: '/resque'
  namespace :api do
    namespace :v1 do
      resources :versions, only: :index, defaults: { format: :json }
      resources :users, only: :index, defaults: { format: :json } do
      	collection do
      	  post :login
          post :post_songs
          get :get_songs
          get :get_friends
      	  delete :logout
      	end
      end
    end
  end
end