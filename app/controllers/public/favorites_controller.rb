class Public::FavoritesController < ApplicationController

  def create
    game = Game.find(params[:game_id])
	  favorite = current_user.favorites.new(game_id: game.id)
    favorite.save
    @game = Game.find(params[:game_id])
  end

  def destroy
    game = Game.find(params[:game_id])
	  favorite = current_user.favorites.find_by(game_id: game.id)
    favorite.destroy
    @game = Game.find(params[:game_id])
  end

end
