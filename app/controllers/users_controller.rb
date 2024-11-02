class UsersController < ApplicationController

  before_action :require_signin, except: [:show, :new, :create]
  before_action :set_user, only: [:show, :update, :edit, :destroy]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for signing up!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @favorites = @user.favorite_flicks
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account update successful!"
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @user ||= set_user

    if @user.destroy
      session.delete(:user_id) if current_user == @user
      redirect_to root_path, status: :see_other, alert: "Account successfully deleted."
    else
      render :edit, notice: "Could not delete account"
    end
  end

  private

  def require_correct_user
    @user ||= set_user

    redirect_to root_path, alert: "You don't have access to this resource.",
                status: :see_other unless user_has_access?(@user)
  end

  def set_user
    @user = User.find_by(username: params[:id])
  end

  def user_params
    params.require(:user)
          .permit(
            :name,
            :email,
            :username,
            :password,
            :password_confirmation
          )
  end

end
