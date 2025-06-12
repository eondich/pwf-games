Rails.application.routes.draw do
  # Make index path meaningful
  namespace :api do
    namespace :v1 do
      # CHARACTER GENERATOR
      get 'character_generator/base_data/:system_id', to: 'character_generator#get_base_system_data'
      get 'character_generator/lineages/:system_id/:ancestry_id', to: 'character_generator#get_lineages'
      get 'character_generator/character_name/:system_id/style/:style', to: 'character_generator#get_new_character_name_by_style'
      get 'character_generator/player_subclasses/:system_id/:player_class_id', to: 'character_generator#get_player_subclasses'
      get 'character_generator/sources', to: 'character_generator#get_source_materials'
      get 'character_generator/game_system/:game_system_key', to: 'character_generator#get_game_system'
    end
  end
end
