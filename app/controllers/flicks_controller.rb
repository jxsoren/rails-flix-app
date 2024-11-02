class FlicksController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_flick, only: [:show, :edit, :update, :destroy]

  def index
    case params[:filter]
    when "upcoming"
      @flicks ||= Flick.upcoming
    when "recent"
      @flicks ||= Flick.recent
    when "released"
      @flicks ||= Flick.released
    when "hits"
      @flicks ||= Flick.hits
    when "flops"
      @flicks ||= Flick.flops
    else
      @flicks ||= Flick.all
    end
  end

  def show
    @fans = @flick.fans
    @genres = @flick.genres.order(name: :asc)

    if current_user
      @favorite = current_user.favorites&.find_by(flick_id: @flick.id)
    end
  end

  def new
    @flick = Flick.new
  end

  def create
    @flick = Flick.new(flick_params)
    if @flick.save
      redirect_to @flick, notice: "Flick successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @flick.update(flick_params)
      flash[:notice] = "Flick successfully updated!"
      redirect_to @flick
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flick.destroy

    redirect_to flicks_path, status: :see_other,
                alert: "Flick successfully deleted!"
  end

  private

  def set_flick
    @flick = Flick.find_by!(slug: params[:id])
  end

  def flick_params
    params.require(:flick)
          .permit(
            :title,
            :description,
            :rating,
            :total_gross,
            :released_on,
            :director,
            :duration,
            :image_file_name,
            genre_ids: []
          )
  end

end
