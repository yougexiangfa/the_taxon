Rails.application.routes.draw do

  scope module: 'taxon' do
    resources :nodes, only: [] do
      collection do
        get :children
        get :outer
        get :outer_search
      end
    end
  end

  scope :admin, module: 'taxon/admin', as: :admin do
    resources :taxons
    resources :tags
  end

end
