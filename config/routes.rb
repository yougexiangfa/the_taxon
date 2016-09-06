Rails.application.routes.draw do

  resources :nodes do
    :node_parents
  end

end
