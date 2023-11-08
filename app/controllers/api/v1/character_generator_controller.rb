class Api::V1::CharacterGeneratorController < ApplicationController
  # GET /character_generator/ancestries/:system_id
  def get_ancestries_by_source
    system_id = params[:id].to_i
    ancestries = Ancestry.includes(:game_systems).where("game_systems.id" => system_id).map { |ancestry| ancestry.serialized_for_character_generator }
    render json: {
      ancestries: ancestries
    }
  end

  # GET /character_generator/system_id/:system_name
  def get_system_id
    system_name = params[:system_name]
    system = GameSystem.find_by(name: system_name)
    render json: {
      system_id: system.id
    }
  end

  # GET /character_generator/genders
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

    render json: {
      gender_options: serialized_genders
    }
  end

  # GET character_generator/character_name/:system/:ancestry/:gender
  def get_new_character_name
    system_id = params[:system].to_i
    ancestry_id = params[:ancestry].to_i
    gender = params[:gender]

    # Skipping source material for now because our data's not up to it, we'll really want to 
    # change this to system as the primary check anyways
    available_names = CharacterName.includes(:ancestries).where("ancestries.id" => ancestry_id)

    given_names = if gender == "nb"
      available_names.where(name_type: "given_name").where(gender: nil)
    elsif gender == "any"
      available_names.where(name_type: "given_name")
    else
      available_names.where(name_type: "given_name").where(gender: gender.to_i)
    end

    surnames = available_names.where(name_type: "surname")

    name = if given_names.count > 0
      given_names[rand(given_names.count)].value
    else
      "Qussk"
    end
    # Not all ancestries use surnames
    if surnames.count > 0
      surname = surnames[rand(surnames.count)]
      name = "#{name} #{surname.value}"
    end

    render json: {
      character_name: name
    }
  end

  # GET /character_generator/player_classes/:source_id
  def get_player_classes_by_source
    system_id = params[:id].to_i
    pclasses = PlayerClass.includes(:game_systems).where("game_systems.id" => system_id).map { |pclass| pclass.serialized_for_character_generator }
    render json: {
      player_classes: pclasses
    }
  end

  # GET /character_generator/sources
  def get_game_systems
    sources = SourceMaterial.all.map { |source| source.serialized_for_character_generator }
    render json: { 
      sources: sources
    }
  end
end