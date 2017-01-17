Rails.application.routes.draw do
  resources :languages, except: [:new, :edit] do
    resources :syllables, except: [:show, :new, :edit]
    resources :words, except: [:show, :new, :edit]
  end

  resources :phonemes, only: [:index]

  # WHEN I ADD USERS, NEST THE ABOVE IN THE FOLLOWING RESOURCE?
  # resource :user do
  #
  # end
end

#index
#create
#new
#edit
#show
#update
#destroy
