Rails.application.routes.draw do
  # Application routes
  resources :languages, except: [:new, :edit]
  resources :syllables, except: [:show, :new, :edit]
  resources :phonemes, only: [:index, :show]
  resources :words, except: [:new, :edit]

  # Elastic Beanstalk Health Check
  get '/health', to: 'home#health'
end
