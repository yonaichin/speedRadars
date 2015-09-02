Rails.application.routes.draw do
  root :to => 'radars#index'
  get 'radar/' => 'radars#index'
  get 'radar/:highway' => 'radars#index'
end

