class Api::V1::CharacterGeneratorController < ApplicationController
  # GET /character_generator/ancestries/:source_id
  def get_ancestries_by_source
    source_material_id = params[:id].to_i
    ancestries = Ancestry.includes(:source_materials).where("source_materials.id" => source_material_id).map { |ancestry| ancestry.serialized_for_character_generator }
    render json: {
      ancestries: ancestries
    }
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