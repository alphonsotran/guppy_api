Rails.application.routes.draw do
  post '/links', to: 'urls#create'
  get '/:id', to: 'urls#show'
end
