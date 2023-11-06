Rails.application.routes.draw do
  # Make index path meaningful
  namespace :api do
    namespace :v1 do
      # CHARACTER GENERATOR
      get 'character_generator/ancestries/:id', to: 'character_generator#get_ancestries_by_source'
      get 'character_generator/player_classes/:id', to: 'character_generator#get_player_classes_by_source'
      get 'character_generator/sources', to: 'character_generator#get_source_materials'
      # FOLLOWERS TABLE
      get 'followers_table/index'
      get 'followers_table/show/:id', to: 'followers_table#show'
      get 'followers_table/player_classes', to: 'followers_table#get_player_classes'
    end
  end
end
