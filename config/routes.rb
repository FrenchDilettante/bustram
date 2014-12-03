Rails.application.routes.draw do

  get '/' => 'static#home', as: :home

  get '/arrets/:id' => "stops#show", as: :stop

  mount V1::Root => '/api'

end
