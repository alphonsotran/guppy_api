Rails.application.routes.draw do
  get '/', to: 'urls#redirect'
  post '/links', to: 'urls#create'
end
