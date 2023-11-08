Rails.application.routes.draw do
  # Make index path meaningful
  namespace :api do
    namespace :v1 do
      # CHARACTER GENERATOR
      get 'character_generator/ancestries/:id', to: 'character_generator#get_ancestries_by_source'
      get 'character_generator/character_name/:system/:ancestry/:gender', to: 'character_generator#get_new_character_name'
      get 'character_generator/genders', to: 'character_generator#get_gender_options'
      get 'character_generator/player_classes/:id', to: 'character_generator#get_player_classes_by_source'
      get 'character_generator/sources', to: 'character_generator#get_source_materials'
      get 'character_generator/system_id/:system_name', to: 'character_generator#get_system_id'
    end
  end
end
