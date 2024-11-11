class Flick < ApplicationRecord
  FLOP_MARGIN_THRESHOLD = 225_000_000
  HIT_MARGIN_THRESHOLD = 300_000_000
  RATINGS = %w(G PG PG-13 R NC-17)

  before_save :set_slug

  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  has_one_attached :main_image
  # validates :acceptable_image

  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, inclusion: RATINGS

  scope :released, -> { where("released_on <  ?", Time.now).order(released_on: :desc) }
  scope :upcoming, -> { where("released_on > ?", Time.now).order(released_on: :desc) }
  scope :recent, -> (max = 5) { released.limit(max) }
  scope :hits, -> (threshold = HIT_MARGIN_THRESHOLD) { released.where("total_gross >= ?", threshold).order(total_gross: :desc) }
  scope :flops, -> (threshold = FLOP_MARGIN_THRESHOLD) { released.where("total_gross < ?", threshold).order(total_gross: :asc) }
  scope :grossed_less_than, ->(gross_value) { where("total_gross < ?", gross_value) }
  scope :grossed_greater_than, ->(gross_value) { where("total_gross > ?", gross_value) }

  def flop?
    unless reviews.count > 50 && average_stars >= 4.00
      total_gross.blank? || total_gross < FLOP_MARGIN_THRESHOLD
    end
  end

  def requires_adult_supervision?
    rating == "R" || rating == "AO"
  end

  def average_stars
    reviews.average(:stars) || 0.00
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100
  end

  def to_param
    self.slug
  end

  private

  def set_slug
    self.slug = title.parameterize
  end

  def acceptable_image
    return unless main_image.attached?

    supported_image_file_types = %w(image/png image/jpeg)
    max_file_size = 1.megabyte

    unless supported_image_file_types.include?(main_image.blob.content_type)
      errors.add(:main_image, "file must be one of the following filetypes #{supported_image_file_types}")
    end

    unless main_image.blob.byte_size <= max_file_size
      errors.add(:main_image, "file must be less than or equal to #{max_file_size}")
    end
  end

end
