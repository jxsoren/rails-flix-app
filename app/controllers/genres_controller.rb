class GenresController < ApplicationController

  before_action :set_genre, only: [:show, :edit, :update, :destroy]

  def index
    @genres = Genre.all
  end

  def show
    @flicks_for_genre = @genre.flicks
  end

  def new
    @genre = Genre.new
  end

  def edit
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to genre_path(@genre), notice: "Genre created successfully!"
    else
      render :new, alert: "Couldn't create genre. Sorry."
    end
  end

  def update
    @genre.update(genre_params)

    redirect_to genres_path, notice: "Genre Updated!"
  end

  def destroy
    @genre.destroy

    redirect_to genres_path, alert: "Genre terminated."
  end

  private

  def set_genre
    @genre = Genre.find_by(lookup_code: params[:id])
  end

  def genre_params
    params
      .require(:genre)
      .permit(:name)
  end

end
