Rails.application.routes.draw do
  get 'orchestrate', to: 'home#orchestrate'
  get 'participate', to: 'home#participate'

  root "home#participate"
end
