class Public::GamesController < ApplicationController
  before_action :authenticate_user!
  def show
    @game = Game.find(params[:id])
    @game_new = Game.new
    @user = @game.user
    @comment = GameComment.new
    @game_comments = @game.game_comments
  end

  def index
    @games = Game.all
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    if @game.save
      redirect_to public_games_path, notice: "You have created book successfully."
    else
      flash[:danger] = @game.errors.full_messages
      @games = Game.all
      render 'index'
    end
  end

  def edit
    @game = Game.find(params[:id])
    if current_user.id != @game.user_id
      redirect_to public_games_path
    end
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to public_game_path(@game), notice: "You have updated book successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to public_games_path
  end

  private
  def game_params
    params.permit(:title, :body, :image_id)
  end
end
