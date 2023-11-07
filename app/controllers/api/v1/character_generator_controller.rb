class Api::V1::CharacterGeneratorController < ApplicationController
  # GET /character_generator/ancestries/:source_id
  def get_ancestries_by_source
    source_material_id = params[:id].to_i
    ancestries = Ancestry.includes(:source_materials).where("source_materials.id" => source_material_id).map { |ancestry| ancestry.serialized_for_character_generator }
    render json: {
      ancestries: ancestries
    }
  end

  # GET /character_generator/genders
  def get_gender_options
    genders = CharacterName.genders

    serialized_genders = genders.map do |gender|
      {
        id: gender[1],
        name: gender[0]
      }
    end

    # Cleaner way to do this?
    serialized_genders.push({
      id: -1,
      name: 'Nonbinary'
    })

    serialized_genders.push({
      id: -2,
      name: 'Any'
    })

    render json: {
      gender_options: serialized_genders
    }
  end

  # GET character_generator/character_name/:src/:ancestry/:gender
  def get_new_character_name
    source_material_id = params[:src].to_i
    ancestry = params[:ancestry]
    gender = params[:gender]
  end

  # GET /character_generator/player_classes/:source_id
  def get_player_classes_by_source
    source_material_id = params[:id].to_i
    pclasses = PlayerClass.includes(:source_materials).where("source_materials.id" => source_material_id).map { |pclass| pclass.serialized_for_character_generator }
    render json: {
      player_classes: pclasses
    }
  end

  # GET /character_generator/sources
  def get_source_materials
    sources = SourceMaterial.all.map { |source| source.serialized_for_character_generator }
    render json: { 
      sources: sources
    }
  end
end