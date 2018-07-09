Rails.application.routes.draw do

  resources :nodes, only: [:index] do
    get :children, on: :collection
    get :outer, on: :collection
  end

end
