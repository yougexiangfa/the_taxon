Rails.application.routes.draw do

  resources :nodes, only: [:index] do
    get :children, on: :collection
    get :outer, on: :collection
    get :outer_search, on: :collection
  end
  scope :admin, module: 'taxon/admin', as: :admin do
    resources :taxons
    resources :tags
  end

end
