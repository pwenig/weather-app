Rails.application.routes.draw do
  get 'forecasts/show'
  root 'forecasts#show'
end
