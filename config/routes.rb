Rails.application.routes.draw do
  root to: 'main#home'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'search/sample', to: 'search#sample'
      get 'search/within', to: 'search#within'
      get 'search/by_name', to: 'search#by_name'
      get 'search/by_unit_id/:unit_id', to: 'search#by_unit_id'
    end
  end
end
