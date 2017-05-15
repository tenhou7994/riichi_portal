Rails.application.routes.draw do

  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'

  delete 'sign_out' => 'sessions#destroy'
  root to: 'main#index'

end