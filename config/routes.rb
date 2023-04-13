Rails.application.routes.draw do
  resources :employees do
    resources :attendances
  end

  resources :attendances, only: [:new, :create]

  resources :salaries do
    collection do
      post 'calculate_salaries'
      get 'edit_base_rate'
      patch 'update_base_rate'
    end
  end

  resources :shifts
  root 'shifts#index'
  resources :attendances
end

  
  

