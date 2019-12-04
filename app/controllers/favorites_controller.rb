class FavoritesController < ApplicationController
  def index
    @favorites = Pet.find(cookies[:favorites].split(','))
  end

  def create
    cookies[:favorites] += "#{!cookies[:favorites].empty? ? ',' : ''}#{params[:id]}"
    flash[:favorited] = "This pet has been added to your favorites! :D"
    redirect_to "/pets/#{params[:id]}"
  end

  def destroy
    favorites = cookies[:favorites].split(',')
    favorites.delete(params[:id])
    cookies[:favorites] = favorites.join(',')
    flash[:unfavorited] = "This pet has been removed from your favorites. :("
    redirect_back(fallback_location: '/favorites')
  end

  def destroy_all
    cookies[:favorites] = []
    redirect_to '/favorites'
  end
end
