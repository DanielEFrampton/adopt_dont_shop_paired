class FavoritesController < ApplicationController
  def index
    @favorited_pets = Pet.find(@favorites.ids)
  end

  def create
    @favorites.add(params[:id])
    session[:favorites] = @favorites.favorited_pets
    flash[:favorited] = "This pet has been added to your favorites! :D"
    redirect_to "/pets/#{params[:id]}"
  end

  def destroy
    @favorites.delete(params[:id])
    flash[:unfavorited] = "This pet has been removed from your favorites. :("
    redirect_back(fallback_location: '/favorites')
  end

  def destroy_all
    @favorites.delete_all
    session[:favorites] = @favorites.favorited_pets
    redirect_to '/favorites'
  end
end
