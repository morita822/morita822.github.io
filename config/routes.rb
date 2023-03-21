Rails.application.routes.draw do
  root 'employees#index'
  resources :employees
  resources :shifts
  resources :salaries
  resources :attendances
  resources :layouts
end
  
  
  

