class Api::V1::CharacterGeneratorController < ApplicationController
  # GET /character_generator/game_system/:system_key
  def get_game_system
    game_system_key = params[:game_system_key]
    game_system = GameSystem.find_by(key: game_system_key)
    render json: {
      game_system: game_system.serialized_for_character_generator
    }
  end

  # GET /character_generator/sources
  def get_game_systems
    sources = SourceMaterial.all.map { |source| source.serialized_for_character_generator }
    render json: { 
      sources: sources
    }
  end

  # GET /character_generator/base_data/:system_id
  def get_base_system_data
    system_id = params[:system_id].to_i
  
    ancestries = get_ancestries(system_id)
    backgrounds = get_backgrounds(system_id)
    name_styles = get_name_styles(system_id)
    player_classes = get_player_classes(system_id)
    appearances = get_appearances(system_id)
    
    res = {
      ancestries: ancestries,
      appearances: appearances,
      backgrounds: backgrounds,
      player_classes: player_classes
    }

    if name_styles.count
      res[:name_styles] = name_styles
    else
      res[:gender_options] = get_gender_options(system_id)
    end

    render json: res
  end

  # GET /character_generator/lineages/:system_id/:ancestry_id
  def get_lineages
    system_id = params[:system_id].to_i
    ancestry_id = params[:ancestry_id].to_i
    lineages = Lineage.where(game_system_id: system_id, ancestry_id: ancestry_id).map { |lineage| lineage.serialized_for_character_generator }
    render json: {
      lineages: lineages
    }
  end

  # GET /character_generator/player_subclasses/:system_id/:player_class_id
  def get_player_subclasses
    system_id = params[:system_id].to_i
    player_class_id = params[:player_class_id].to_i
    subclasses = PlayerSubclass.includes(:game_systems)
                               .includes(:player_class)
                               .where("game_systems.id" => system_id)
                               .where("player_class.id" => player_class_id)
                               .map { |subclass| subclass.serialized_for_character_generator }
    render json: {
      player_subclasses: subclasses
    }
  end

  # GET /character_generator/character_name/:system_id/style/:style
  def get_new_character_name_by_style
    system_id = params[:system_id].to_i
    style_id = params[:style].to_i

    available_names = if style_id > -1
      CharacterName.includes(:name_styles).includes(:game_systems).where("game_systems.id" => system_id).where("name_styles.id" => style_id)
    else
      CharacterName.includes(:game_systems).where("game_systems.id" => system_id)
    end

    name = generate_name(system_id, available_names, nil)
    
    render json: {
      character_name: name
    }
  end

  private

  def get_ancestries(system_id)
    Ancestry.includes(:game_systems).where("game_systems.id" => system_id).map { |ancestry| ancestry.serialized_for_character_generator }
  end

  def get_appearances(system_id)
    CharacterAppearance.where(game_system_id: system_id).map { |a| a.serialized_for_character_generator }
  end

  def get_backgrounds(system_id)
    Background.where(game_system_id: system_id).map { |bg| bg.serialized_for_character_generator }
  end

  def get_gender_options
    genders = CharacterName.genders

    serialized_genders = genders.map do |gender|
      {
        id: gender[1].to_s,
        name: gender[0].titleize
      }
    end

    serialized_genders.push({
      id: "nb",
      name: 'Nonbinary'
    })

    serialized_genders.push({
      id: "any",
      name: 'Any'
    })

    serialized_genders
  end

  def get_name_styles(system_id)
    NameStyle.includes(:game_systems).where("game_systems.id" => system_id).map { |style| style.serialized_for_character_generator }
  end

  def get_player_classes(system_id)
    PlayerClass.includes(:game_systems).where("game_systems.id" => system_id).map { |pclass| pclass.serialized_for_character_generator }
  end

  def generate_name(system_id, available_names, gender)
    given_names = available_names.where(name_type: "given_name")

    if gender
      if gender == "nb"
        given_names = given_names.where(gender: nil)
      elsif gender != "any"
        given_names = given_names.where(gender: gender.to_i)
      end
    end

    family_name = available_names.where(name_type: "family_name")

    name = if given_names.count > 0
      given_names[rand(given_names.count)].value
    else
      "Hero"
    end

    # Not all ancestries use family_name
    if family_name.count > 0
      family_name = family_name[rand(family_name.count)]
      name = "#{name} #{family_name.value}"
    end

    name
  end
end