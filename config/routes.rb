Rails.application.routes.draw do
  root to: 'main#home'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'sample', to: 'search#sample'
    end
  end
end
