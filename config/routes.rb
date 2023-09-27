Rails.application.routes.draw do
  # Make index path meaningful
  namespace :api do
    namespace :v1 do
      get 'followers_table/index'
      get 'followers_table/show/:id', to: 'followers_table#show'
      get 'followers_table/player_classes', to: 'followers_table#get_player_classes'
    end
  end
end
