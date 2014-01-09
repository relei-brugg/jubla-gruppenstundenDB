class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :user_owner,     only: [:edit, :update]
  before_action :moderator_user, only: [:toggle_moderator]
  before_action :admin_user,     only: [:destroy, :toggle_admin]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def toggle_admin
    user = User.find(params[:id])
    if user.update_attribute(:admin, !user.admin)
      flash[:success] = 'User changed'
    elsif
      flash[:danger] = 'User not changed'
    end
    redirect_to action: :index
  end

  def toggle_moderator
    user = User.find(params[:id])
    if user.update_attribute(:moderator, !user.moderator)
      flash[:success] = 'User changed'
    elsif
      flash[:danger] = 'User not changed'
    end
    redirect_to action: :index
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end


end