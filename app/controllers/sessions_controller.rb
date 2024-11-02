class SessionsController < ApplicationController

  def new

  end

  def create
    @user = find_by_email_or_username

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect_to user_path_or_intended_url, notice: "Welcome back, #{@user.name}!"
      session.delete(:intended_url)
    else
      flash.now[:alert] = "Incorrect email and/or password."
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: "Successfully logged out!", status: :see_other
  end

  private

  def user_path_or_intended_url
    return session[:intended_url] unless session[:intended_url].nil?

    user_path(@user)
  end

  def find_by_email_or_username
    User.find_by(email: params[:email_or_username]) || User.find_by(username: params[:email_or_username])
  end

end

