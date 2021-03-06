Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'home#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/shelters/:id/pets', to: 'shelters#pets' # Change later to live on Pets controller
  post '/shelters/:id/pets', to: 'pets#create'
  get '/shelters/:id/pets/new', to: 'pets#new'
  get 'pets/:id/edit', to: 'pets#edit'
  patch 'pets/:id', to: 'pets#update'
  delete 'pets/:id', to: 'pets#destroy'
  patch '/pets/:pet_id/applications/:application_id/:new_status', to:'pets#update_status'

  post 'pets/:id/favorites', to: 'favorites#create'
  get '/favorites', to: 'favorites#index'
  delete '/favorites/:id', to: 'favorites#destroy'
  delete '/favorites', to: 'favorites#destroy_all'

  get '/shelters/:id/reviews/new', to: 'reviews#new'
  get '/reviews/:id/edit', to: 'reviews#edit'
  post '/shelters/:id', to: 'reviews#create'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  get '/applications/new', to: 'applications#new'
  get '/applications/:id', to: 'applications#show'
  post '/applications', to: 'applications#create'
  get '/pets/:id/applications', to: 'applications#index'
end
