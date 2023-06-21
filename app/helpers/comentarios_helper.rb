# frozen_string_literal: true
module ComentariosHelper
  def render_star_rating(rating)
    stars = "★" * rating + "☆" * (5 - rating)
      content_tag(:span, stars, class: "star-rating")
  end
end
