class ReviewsController < ApplicationController

  before_action :set_flick
  before_action :require_signin, only: [:new, :create]

  def index
    @reviews = @flick.reviews
  end

  def new
    @review = @flick.reviews.new
  end

  def create
    @review = @flick.reviews.new(review_params)
    @review.user = current_user
    @review.save

    if @review.save
      redirect_to flick_review_path(@flick, @review), notice: "Created!"
    else
      render :new, status: :unprocessable_entity, alert: "You failed!"
    end
  end

  def show
    @review = @flick.reviews.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.update(params[:id])
  end

  def destroy
    Review.destroy(params[:id])
  end

  private

  def set_flick
    @flick = Flick.find_by!(slug: params[:flick_id])
  end

  def review_params
    params.require(:review)
          .permit(
            :stars,
            :comment
          )
  end

end
