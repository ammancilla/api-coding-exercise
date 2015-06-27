Rails.application.routes.draw do
  
  # -- API
  namespace :api, defaults: { format: 'json' } do
    api_version(module: 'v1', path: { value: 'v1' }, default: true) do
      
      # Group Events
      resources :group_events, except: [:new, :edit]
    end
  end
end
