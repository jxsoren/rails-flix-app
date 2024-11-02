module FavoritesHelper

  def fave_or_unfave(favorite:, flick:)
    if favorite
      button_to "♥️", flick_favorite_path(flick_id: favorite.flick, id: favorite.id),
                method: :delete, data: { turbo_method: :delete }
    else
      button_to "♡", flick_favorites_path(flick)
    end
  end
end

