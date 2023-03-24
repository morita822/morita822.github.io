Rails.application.routes.draw do
  resources :salaries do
    collection do
      post 'calculate_salaries'
    end
  end
  
  resources :salaries do
    collection do
      get 'edit_base_rate'
      patch 'update_base_rate'
    end
  end

  resources :employees do
    resources :attendances
  end  
  
  root 'shifts#index'
  resources :employees
  resources :shifts
  resources :salaries
  resources :attendances
  resources :layouts
end
  
  
  

