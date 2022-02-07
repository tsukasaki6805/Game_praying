class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except:[:top, :about]

  def show
    @user = User.find(params[:id])
    @games = @user.books
    @game = Game.new
  end

  def index
    @users = User.all
    @game = Game.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    if @user != User.find(current_user.id)
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :nickname, :introduction, :profileimage)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
