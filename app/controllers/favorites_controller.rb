class FavoritesController < ApplicationController

  before_action :require_signin
  before_action :set_flick

  def create
    @favorite = @flick.favorites.create!(user: current_user)

    redirect_to flick_path(@flick)
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy!

    redirect_to flick_path(@flick)
  end

  private

  def set_flick
    @flick = Flick.find_by(slug: params[:flick_id])
  end

end
