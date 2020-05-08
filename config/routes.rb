Rails.application.routes.draw do
  post '/links', to: 'urls#create'
end
