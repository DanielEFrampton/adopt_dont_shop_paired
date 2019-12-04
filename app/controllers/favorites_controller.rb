class FavoritesController < ApplicationController
  def create
    flash[:favorited] = "This pet has been added to your favorites!"
    redirect_to "/pets/#{params[:id]}"
  end
end
