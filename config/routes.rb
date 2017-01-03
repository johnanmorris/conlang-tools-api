Rails.application.routes.draw do
  resources :languages, except: [:new, :edit]
end
