Rails.application.routes.draw do
  resources :languages, except: [:new, :edit] do
    resources :phonemes, only: [:index]
    resources :syllables, except: [:show, :new, :edit]
  end

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
