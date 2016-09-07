Rails.application.routes.draw do

  resources :nodes do
    get :top, on: :collection
    resources :node_parents
  end

end
