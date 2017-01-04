Rails.application.routes.draw do
  resources :languages, except: [:new, :edit] do
    resources :phonemes, except: [:show, :new, :edit]
    resources :syllables, except: [:show, :new, :edit]
  end
end
