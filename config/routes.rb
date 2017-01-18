Rails.application.routes.draw do
  resources :languages, except: [:new, :edit] do
    resources :syllables, except: [:show, :new, :edit]
  end

  resources :phonemes, only: [:index, :show]
  resources :words, except: [:new, :edit]
end
