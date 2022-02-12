class Public::GameCommentsController < ApplicationController

  def create
    @game = Game.find(params[:game_id])
    comment = GameComment.new(game_comment_params)
    comment.user_id = current_user.id
    comment.game_id = @game.id
    comment.save
    @game_comments = @game.game_comments
    @comment = GameComment.new

    # comment = current_user.game_comments.new(game_comment_params)
    # comment.save
    # redirect_to public_games_path(game_comment)
  end

  def destroy
    comment = GameComment.find(params[:id])
    game = comment.game
    comment.destroy
    @game_comments = game.game_comments
    @game = Game.find(params[:game_id])
    @comment = GameComment.new
  end

  private
  def game_comment_params
    params.require(:game_comment).permit(:comment)
  end

end
