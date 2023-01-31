Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post '/save-note' => 'webhooks#save_note'

  # Defines the root path route ("/")
  # root "articles#index"
end
