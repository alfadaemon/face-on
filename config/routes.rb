FaceOn::Application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :criminals, :via => [:get, :post]
    end
  end

  resources :criminals

  post 'dashboards/filtro' => 'dashboards#filtro'

  resources :dashboards, :only => [:index, :show]

  root :to => 'dashboards#index'
end
