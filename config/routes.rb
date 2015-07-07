Rails.application.routes.draw do
  
  root 'keywords#index'

  resources :keywords

end
