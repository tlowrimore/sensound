Rails.application.routes.draw do
  resource :home, only: [:show]

  root "home#show"
end
