class Api::V1::FollowersTableController < ApplicationController
  def index
    puts "here"
    f = FollowerRoll.first
    f.test
  end

  # GET /followers_table/show/:id
  def show
    # Data cleanup?
    player_class_id = params[:id]
    follower_table = FollowerRoll.where(player_class_id: player_class_id).map { |roll| roll.serialized_for_generator }
    render json: { 
      follower_table: follower_table
     }
  end

  # GET /followers_table/player_classes
  def get_player_classes
    player_classes = PlayerClass.all.map { |pclass| pclass.serialized_for_follower_generator }
    render json: {
      player_classes: player_classes
    }
  end
end
