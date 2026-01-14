class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @illusts = current_user.favorited_illusts
  end
end
