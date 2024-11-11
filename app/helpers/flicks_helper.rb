module FlicksHelper

  def main_image_tag(flick)
    if flick.main_image.attached?
      image_tag flick.main_image
    else
      image_tag "placeholder.png"
    end
  end

  def total_gross(flick)
    if flick.flop?
      "Flop!"
    else
      number_to_currency(flick.total_gross, precision: 0)
    end
  end

  def year_of(flick)
    flick.released_on.year
  end

  def viewer_discretion_needed?(flick)
    flick.requires_adult_supervision?
  end

  def average_stars(flick)
    if flick.average_stars.zero?
      content_tag(:strong, "No reviews")
    else
      "*" * flick.average_stars.round
    end
  end

end
