module ReviewsHelper
  def star_rating(value)
    return unless value.respond_to?(:round)
    rounded = value.round
    filled_stars = '★' * rounded
    unfilled_stars = '☆' * (5 - rounded)
    filled_stars + unfilled_stars
  end
end
