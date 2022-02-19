class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except:[:top, :about]

  def show
    @user = User.find(params[:id])
    @games = @user.games
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
      redirect_to public_user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path(@user), notice: "You have updated user successfully."
    else
      render 'edit'
    end
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end


  private
  def user_params
    params.require(:user).permit(:name, :nickname, :email, :introduction, :profileimage)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to public_user_path(current_user)
    end
  end


end
