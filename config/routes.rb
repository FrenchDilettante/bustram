Rails.application.routes.draw do

  get '/' => 'static#home', as: :home

  mount V1::Root => '/api'

end
