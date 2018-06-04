Rails.application.routes.draw do
root 'home#index'
get '/home/search' => "home#search"
end
